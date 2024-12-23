#!/usr/bin/env python
import chaos_pb2 as chaos

message = chaos.gtfs__realtime__pb2.FeedMessage()
import kombu

message.entity.add()
message.entity[0].id = "foo"
message.header.gtfs_realtime_version = "1.0"
s = message.SerializeToString()
kombu.Connection("amqp://guest:guest@localhost//")
c = kombu.Connection("amqp://guest:guest@localhost//")
c.Producer()
p = c.Producer()
p.publish(s, exchange="navitia", routing_key="shortterm.transilien")
