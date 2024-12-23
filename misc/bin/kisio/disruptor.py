from __future__ import print_function
import gtfs_realtime_pb2, chaos_pb2
import uuid
import datetime, calendar
from kombu.connection import BrokerConnection
from kombu.entity import Exchange
import kombu
import time
import argparse
import sys
import random

TOPIC = 'shortterm.tr_transilien'

def to_timestamp(date):
    """
    convert a datatime objet to a posix timestamp (number of seconds from 1070/1/1)
    """
    return int(calendar.timegm(date.utctimetuple()))


class PtObject(object):
    def __init__(self, uri, type):
        self.uri = uri
        self.type = type

class Line(PtObject):
    def __init__(self, uri):
        self.uri = uri
        self.type = 'line'

class LineSection(Line):
    def __init__(self, uri, start, end):
        self.uri = uri
        self.start = start
        self.end = end
        self.type = 'line_section'


class Disruption(object):
    def __init__(self, impacted_obj, start, end, blocking=True):
        self.id = str(uuid.uuid4())
        self.impacted_obj = impacted_obj
        self.start = start
        self.end = end
        self.is_deleted = False
        self.blocking = blocking

        self.cause = "CauseTest"
        self.message = "This Is a test"


    def to_pb(self):
        feed_message = gtfs_realtime_pb2.FeedMessage()
        feed_message.header.gtfs_realtime_version = '1.0'
        feed_message.header.incrementality = gtfs_realtime_pb2.FeedHeader.DIFFERENTIAL
        feed_message.header.timestamp = 0

        feed_entity = feed_message.entity.add()
        feed_entity.id = self.id
        feed_entity.is_deleted = self.is_deleted

        disruption = feed_entity.Extensions[chaos_pb2.disruption]

        disruption.id = self.id
        disruption.cause.id = self.cause
        disruption.cause.wording = self.cause
        disruption.reference = "DisruptionTest"
        disruption.publication_period.start = to_timestamp(self.start)
        disruption.publication_period.end = to_timestamp(self.end)

        if not self.impacted_obj:
            return feed_message.SerializeToString()

        # Impacts
        impact = disruption.impacts.add()
        impact.id = "impact_" + self.id + "_1"
        enums_impact = gtfs_realtime_pb2.Alert.DESCRIPTOR.enum_values_by_name
        impact.created_at = to_timestamp(datetime.datetime.utcnow())
        impact.updated_at = impact.created_at
        if self.blocking:
            impact.severity.effect = enums_impact["NO_SERVICE"].number
            impact.severity.id = 'blocking'
            impact.severity.priority = 10
            impact.severity.wording = "blocking"
            impact.severity.color = "#FFFF00"
        else:
            impact.severity.effect = enums_impact["UNKNOWN_EFFECT"].number
            impact.severity.id = 'not blocking'
            impact.severity.priority = 1
            impact.severity.wording = "not blocking"
            impact.severity.color = "#FFFFF0"

        # ApplicationPeriods
        application_period = impact.application_periods.add()
        application_period.start = to_timestamp(self.start)
        application_period.end = to_timestamp(self.end)

        # PTobject
        type_col = {
            "network": chaos_pb2.PtObject.network,
            "stop_area": chaos_pb2.PtObject.stop_area,
            "line": chaos_pb2.PtObject.line,
            "line_section": chaos_pb2.PtObject.line_section,
            "route": chaos_pb2.PtObject.route,
            "stop_point": chaos_pb2.PtObject.stop_point,
        }

        ptobject = impact.informed_entities.add()
        ptobject.uri = self.impacted_obj.uri
        ptobject.pt_object_type = type_col.get(self.impacted_obj.type, chaos_pb2.PtObject.unkown_type)
        if ptobject.pt_object_type == chaos_pb2.PtObject.line_section:
            line_section = ptobject.pt_line_section
            line_section.line.uri = self.impacted_obj.uri
            line_section.line.pt_object_type = chaos_pb2.PtObject.line
            pb_start = line_section.start_point
            pb_start.uri = self.impacted_obj.start
            pb_start.pt_object_type = chaos_pb2.PtObject.stop_area
            pb_end = line_section.end_point
            pb_end.uri = self.impacted_obj.end
            pb_end.pt_object_type = chaos_pb2.PtObject.stop_area

        # Message with one channel and two channel types: web
        message = impact.messages.add()
        message.text = self.message
        message.channel.name = "web"
        message.channel.id = "web"
        message.channel.max_size = 250
        message.channel.content_type = "html"
        message.channel.types.append(chaos_pb2.Channel.web)

        return feed_message.SerializeToString()

    def publish(self, producer):
        producer.publish(self.to_pb())

    def delete(self, producer):
        self.is_deleted = True
        producer.publish(self.to_pb())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--sleep', help='sleep time', default=10, type=int)
    parser.add_argument('--period', help='sleep time', default=10, type=int)
    parser.add_argument('--broker', help='connection string to rabbit', default="pyamqp://guest:guest@localhost:5672")
    parser.add_argument('--one', help='Only send one disruption', default=False, action='store_true')
    args = parser.parse_args()
    sleep_time = args.sleep
    period = args.period
    only_one = args.one
    impacts = [
        LineSection("line:DUA:810801041", "stop_area:DUA:SA:8775810", "stop_area:DUA:SA:8738221"),  # A Nation -> la defense
        LineSection("line:DUA:810802061", "stop_area:DUA:SA:8727103", "stop_area:DUA:SA:8775860"),  # B Gare du nord - Chatelet
        LineSection("line:DUA:800803071", "stop_area:DUA:SA:8778543", "stop_area:DUA:SA:8732832"),  # C St michel -> Bibliotheque F
        LineSection("line:DUA:800804081", "stop_area:DUA:SA:8727103", "stop_area:DUA:SA:8775860"),  # D Gare du nord - Chatelet
        LineSection("line:DUA:810801041", "stop_area:DUA:SA:8738221", "stop_area:DUA:SA:8775810"),  # A la defense -> Nation
        LineSection("line:DUA:810802061", "stop_area:DUA:SA:8775860", "stop_area:DUA:SA:8727103"),  # B Chatelet -> Gare du nord
        LineSection("line:DUA:800803071", "stop_area:DUA:SA:8732832", "stop_area:DUA:SA:8778543"),  # C Bibliotheque F -> St michel
        LineSection("line:DUA:800804081", "stop_area:DUA:SA:8775860", "stop_area:DUA:SA:8727103"),  # D Chatelet -> Gare du nord

        #Line("line:DUA:800805091"),  # E
        Line("line:DUA:800853022"),  # K
        Line("line:DUA:800853021"),  # H
        Line("line:DUA:800854042"),  # L
    ]
    random.shuffle(impacts)
    print("connecting to {} sleeptime: {}".format(args.broker, sleep_time))
    #time.sleep(5)
    connection = BrokerConnection(args.broker)
    producer = kombu.Producer(connection, kombu.Exchange("navitia", type='topic'), TOPIC)

    #producer.publish(item, exchange=self._exchange, routing_key=rt_topic, declare=[self._exchange])
    disruptions = []
    try:
        while True:
            disruptions = []
            for v in impacts:
                disruption = Disruption(v, datetime.datetime.utcnow(), datetime.datetime.utcnow()+datetime.timedelta(minutes=period))
                disruptions.append(disruption)
                disruption.publish(producer)
                if only_one:
                    sys.exit(0)
                time.sleep(sleep_time)
            for d in disruptions:
                d.delete(producer)
                time.sleep(sleep_time)
            print('.', end='')
            sys.stdout.flush()
    except KeyboardInterrupt:
        print("cleanup of disrutpions")
        for d in disruptions:
            d.delete(producer)



if __name__ == "__main__":
    main()



