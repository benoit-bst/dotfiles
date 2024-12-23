# Run Kraken

kraken is composed of

* kraken binary file
* kraken.ini configuration file
* data file (data.nav.lz4)

## Input

* zmq (protobuf request)

## Output

* zmq (protobuf hit)

## Datas

* Compress file (lz4) with ntfs, osm, etc

## Default Configuration file

```bash
[GENERAL]

#file to load
database = data.nav.lz4

#ipc socket in default.ini file in the jormungandr instances dir
zmq_socket = ipc:///tmp/default_kraken

#number of threads
nb_threads = 1

#name of the instance
instance_name=default

[LOG]

log4cplus.rootLogger=DEBUG, ALL_MSGS
log4cplus.appender.ALL_MSGS=log4cplus::ConsoleAppender
log4cplus.appender.ALL_MSGS.File=kraken.log
log4cplus.appender.ALL_MSGS.layout=log4cplus::PatternLayout
log4cplus.appender.ALL_MSGS.layout.ConversionPattern=[%D{%y-%m-%d %H:%M:%S,%q}] %b:%L [%-5p] - %m %n
```

## Compile, run and test

```bash
cmake source_dir
make -j5
./kraken
```

```bash
# in virt env jormun
make test

# docker test
# in virt env eitri
make docker_test
```

# Run Jormungandr

Jormungandr is composed of

* honcho service (run manage.py) in virtual env
* .env (Python var, etc) for honcho
* default.json configuration file

## Input

* Get

## Output

* Json response

## Datas

* Bdd user, auth, zmq kraken responses

## .env

```bash
PYTHONPATH=.:../navitiacommon JORMUNGANDR_INSTANCES_DIR=/home/bbrisset/dev/run/jormungandr
```

## Default Configuration file jormun

```bash
"key": "kraken_instance_name",
"zmq_socket": "ipc:///tmp/default_kraken"
```

## Run

```bash
honcho start
# or in stand alone
PYTHONPATH=.:../navitiacommon ./jormungandr/manage.py
```

Disable bdd :

* In default_settings.py

```python
DISABLE_DATABASE =  boolean(os.getenv('JORMUNGANDR_DISABLE_DATABASE', True))
```

```python
INSTANCE_TIMEOUT = 20000000
```

for test :

```python
PYTHONPATH=.:../navitiacommon JORMUNGANDR_INSTANCES_DIR=/home/bbrisset/dev/build/release/tests/ python jormungandr/manage.py runserver
```

## handle Bdd

```bash
# Create Bdd navitia
createdb -O navitia navitia

# Suppress Bdd
dropdb navitia

# Add extension
sudo -i -u postgres psql -c "create extension postgis; " "navitia"

# upgrade Bdd with alembic in source/sql
PYTHONPATH=. alembic upgrade head

# add new revision
# modify source/sql/models/bdd.py
PYTHONPATH=. alembic revision --autogenerate -m "Message"
# suppress useless line !!!
PYTHONPATH=. alembic upgrade head

```

## Create date set with eitri

eitri is capable to create your own dataset without postgre installation. It use docker, when it's finish docker is shuting down.

```bash
cd /home/bbrisset/dev/navitia/source/eitri
PYTHONPATH=.:../navitiacommon python eitri.py folder_with_osm_ntfs
```

## jenkins

Pour la prod :

```bash
ssh jenkins2
```

## Tests Python

pytest

```bash
PYTHONPATH=.:../navitiacommon KRAKEN_BUILD_DIR=/home/bbrisset/dev/build/release py.test tests
-x : stop after test failed
-k Unit_test_name
```

## Tyr

Tyr is based on python. 2 mains services exist :

* Flask Rest Full Api
* Celery tasks (cron services)

You can :

* Load data in Ed
* Create .na.lz4
* reload kraken
* load data in mimir
* scan instance
* etc ....

The mission is around the data :-)



<!---
--------------------------------------------------------------------------
-->


## Mimir

Warning, The coverage name have to be the same in elasticsearch and jormun

```bash
# for fr-idf
./ntfs2mimir -c http://localhost:9200/munin -d fr-idf -i /home/bbrisset/dev/dataset/fr-idf/ntfs

# screen with http://127.0.0.1:9200/_cat/indices

yellow open .kibana                                      1 1     1 0 6.1kb 6.1kb
yellow open munin_stop_fr-idf_20180807_112709_680637523  1 1 18075 0 7.1mb 7.1mb
yellow open munin_global_stops_20180807_112706_749021937 1 1 18075 0 7.6mb 7.6mb

# kraken and jormun coverage
fr-idf

```

### mimir requests

```request
http://bragi-ws.ctp.dev.canaltp.fr/autocomplete?pt_dataset=fr-idf&q=couronnes
```

### Add Autocomplete in Jormun

mimir into jormun you have to set parameters like this :

```python
AUTOCOMPLETE_SYSTEMS = {
   'kraken': {

       "class": "jormungandr.autocomplete.kraken.Kraken",
   },
   'bragi': {
       "class": "jormungandr.autocomplete.geocodejson.GeocodeJson",
       'args': {
           "host": "http://127.0.0.1:4000",
           "timeout": 2,
       }
   }
}
```

and comment this line.

```python
# This should be moved in a central configuration system like ectd, consul, etc...
AUTOCOMPLETE_SYSTEMS = json.loads(os.getenv('JORMUNGANDR_AUTOCOMPLETE_SYSTEMS', '{}')) or None
```

### Compile mimir and bragi

```bash
# In mimir_source
cargo build --release

# In target/release
./bragi

```

### Request bragi

```bash
http://127.0.0.1:4000/metrics
```

### Run elasticsearch

Install elasticsearch 2.4

```bash
./elasticsearch-2.4.1/bin/elasticsearch
```

Request elasticsearch to print dataset

```bash
http://127.0.0.1:9200/_cat/indices
```

### Run kibana

Install kibana 4.6

```bash
./kibana-4.6.0/bin/kibana
```

### Feed elasticsearch with data set

Run in mimir_source/target/release/ntfs2mimir :

```bash
./ntfs2mimir -c http://localhost:9200/munin -d fr-idf -i /home/bbrisset/dev/dataset/fr-idf/ntfs
```

### Erase a dateset from elasticsearch

```bash
curl -X DELETE 'http://localhost:9200/_all'
curl -X DELETE 'http://localhost:9200/data_name'
```

### My first local request

you can send request with playground

```request
# With kraken autocomplete
http://localhost:5000/v1/coverage/fr-idf/places?q=rennes&_autocomplete=kraken&type%5B%5D=stop_area&5

# With bragi autocomplete
http://localhost:5000/v1/coverage/fr-idf/places?q=rennes&_autocomplete=bragi&type%5B%5D=stop_area&5
```
<!---
--------------------------------------------------------------------------
-->



## debug on dev

On dev-bina :

psql -l
psql -d jormungandr

SELECT * FROM job
SELECT * FROM data_set WHERE name LIKE blabla;
name like '%----%'

## create package

as root project

```bash
DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -j1 -b -us -uc
```

## mimir

cargo build
cargo test

cargo +nightly fmt
cargo +nightly clippy

# docker debian

```bash
docker run -v "/home/bbrisset/dev:/bbst" -ti navitia/debian8_dev bash
```

## Artemis

Find a good data to create the case.
Create artemis data with eitri, and run kraken and jormun.

After complete in artemis a request, push on artemis, and run custom_artemis_reference_PR_and_artemis_PR_build with it.
Retrieve the test that failed, and take the reference for artemis_reference.

With artemis ng

```
artemis_up
artemis_down (-v to clean volumes)
```

## Create release

Faire une release :
1. Dans /root_project -> python script_release.py minor (ou major ou hotfix) navitia_remote_name
2. Ca ouvre le changelog. vérifier le changelog, le rendre plus lisible si possible. Enregister, la branche "release/version" et "release" sont a jour avec le changelog
3. repasser sur la branche de dev et récupérer les modifications (git checkout dev, git merge release)
4. Lancer les tests (les dockers aussi)
5. Attendre que les tests Artemis soit good
6. Si c'est good alors on pousse dev et release (git push navitia_depot release dev --tags) (modifié)

## view config on tyr

```bash
http://tyr-urlv0/instances/stif
```

<!---
--------------------------------------------------------------------------
-->

## run Galting

1. Jormun

Config uwsgi :

```ini
[uwsgi]
plugins = python
http-socket = :5000
wsgi-file = manage.py
callable = app
processes = 4
lazy-apps = True
gevent = 4
enable-threads = True
```

in source/jormungandr/jormungandr :


```bash
PYTHONPATH=/home/bbrisset/dev/navitia/source/navitiacommon:/home/bbrisset/dev/navitia/source/jormungandr JORMUNGANDR_CONFIG_FILE=default_settings.py JORMUNGANDR_INSTANCES_DIR=/home/bbrisset/dev/run/jormungandr uwsgi gatling_jormun.ini
```

2. kraken

kraken_make_r avec le coverage a fr-idf

3. gatling

```bash
/home/bbrisset/soft/gatling-charts-highcharts-bundle-2.3.1/bin/gatling.sh -df /home/bbrisset/dev/navitia/gatling/data -sf /home/bbrisset/dev/navitia/gatling/simulations
```

<!---
--------------------------------------------------------------------------
-->

## Debug on artemis machine

```bash
ssh artemis
# in /var/lib/jenkins/workspace/Artemis
py.test artemis/tests/guichet_unique_test.py -k test_name -v --full-trace -s --skip_bina --skip_cities
```

## Debug Artemis (local)

test artemis with jenkins job : custom_artemis_reference_branch_and_artemis_branch_build

1. For rabbitmq run

```bash
http://localhost:15672
```
Check exchanges with kraken_par_lap06_cover_rt -> realtime.cots
Check queue with kraken_par_lap06_cover_rt

2. kraken config

```bash
#name of the instance
instance_name=fr-idf

is_realtime_enabled = false
is_realtime_add_enabled = true

# in ms (optional)
kirin_timeout = 180000 #

##############################
# BROKER
#############################
[BROKER]
host = localhost
port = 5672
username = guest
password = guest
exchange = navitia
vhost = /

rt_topics = realtime.cots
```
with the good .naz for kraken. Create data with artemis_data (eitri)

3. config kirin

```bash
NAVITIA_URL = os.getenv('KIRIN_NAVITIA_URL','http://127.0.0.1:5000/')

NAVITIA_TIMEOUT = 5

NAVITIA_INSTANCE = os.getenv('KIRIN_NAVITIA_INSTANCE', 'fr-idf')

NAVITIA_TOKEN = os.getenv('KIRIN_NAVITIA_TOKEN', None)

CONTRIBUTOR = os.getenv('KIRIN_CONTRIBUTOR', 'realtime.cots')

CELERY_BROKER_URL = os.getenv('KIRIN_CELERY_BROKER_URL',
                              'pyamqp://guest:guest@localhost:5672//?heartbeat=60')


# COTS configuration
# * external configuration
COTS_CONTRIBUTOR = os.getenv('KIRIN_COTS_CONTRIBUTOR', 'realtime.cots')
```
4. COTS

feeding kirin with a COTS file (with a rest client)

Post on http://localhost:5001/cots

Run with playground to see the artemis request

5. Bdd kirin

flush bdd with

```
delete from associate_realtimeupdate_tripupdate;
delete from real_time_update;
delete from stop_time_update;
delete from trip_update;
delete from vehicle_journey;

```
## add new ref and COTS in Artemis

1. Create COTS

find a good VJ
http://navitia2-ws.ctp.customer.canaltp.fr/v1/coverage/sncf/vehicle_journeys with vehicle_journeys

show codes :
http://navitia2-url/v1/coverage/sncf/vehicle_journeys?data_freshness=base_schedule&headsign=848818&depth=2&show_codes=true&

now you have all informations to create your own COTS files

2. Create Reference

Create function in artemis to call COTS.
Run test with artemis NG.
The test will failed, then you select the response to become a reference

## Artemis NG

1. work with kirin

Run the navitia docker-compose:

```
docker-compose -f docker-compose.yml -f artemis/docker-artemis-instance.yml -f kirin/docker-compose_kirin.yml up
```

Stop the compose:

```
docker-compose -f docker-compose.yml -f artemis/docker-artemis-instance.yml -f kirin/docker-compose_kirin.yml down -v
```

With a single instance (auv exemple):

```
version: '2'

services:

  kraken-fr-auv:
    image: navitia/kraken:${TAG}
    environment:
        - KRAKEN_GENERAL_instance_name=fr-auv
        - KRAKEN_GENERAL_database=/srv/ed/output/fr-auv.nav.lz4
        - KRAKEN_BROKER_host=rabbitmq
        
    volumes_from:
      - tyr_beat:ro
    expose:
      - "30000"


  jormungandr:
    environment:

      - JORMUNGANDR_INSTANCE_fr-auv={"key":"fr-auv","zmq_socket":"tcp://kraken-fr-auv:30000"}

      - JORMUNGANDR_CACHE_CONFIGURATION={"CACHE_TYPE":"simple", "CACHE_KEY_PREFIX":"jormungandr.", "TIMEOUT_PTOBJECTS":0.001, "TIMEOUT_AUTHENTICATION":0.001, "TIMEOUT_PARAMS":0.001, "TIMEOUT_TIMEO":60, "TIMEOUT_SYNTHESE":30}


  instances_configurator:
    environment:

      - INSTANCE_fr-auv=
```

2. Run artemis 

with config :

```
# encoding: utf-8
import os

USE_ARTEMIS_NG = True

# Path to artemis_data folder
DATA_DIR = "/home/bbrisset/dev/artemis_data"

CITIES_INPUT_FILE = DATA_DIR + "/france_boundaries.osm.pbf"

RESPONSE_FILE_PATH = '/home/bbrisset/dev/artemis/output'

# Path to artemis_references folder
REFERENCE_FILE_PATH = '/home/bbrisset/dev/artemis_references/'

KIRIN_API = 'http://localhost:9090'

JORMUNGANDR_DB = 'dbname=jormungandr user=jormungandr host=localhost password=jormungandr'

KIRIN_DB = 'dbname=kirin user=navitia host=localhost password=navitia port=9494'

CITIES_DB = 'dbname=cities user=navitia host=localhost password=password'

# By default, the requests will be made locally. But it can be directed to any Jormun/Tyr instance
URL_JORMUN = 'http://localhost:9191'
URL_TYR = 'http://localhost:9898'
```

run one test

```
# in artemis/artemis
CONFIG_FILE=/home/bbrisset/dev/artemis/artemis/dev_settings.py pytest -k test_kirin_cots_trip_delay
CONFIG_FILE=/home/bbrisset/dev/artemis/artemis/dev_settings.py pytest -k guichet_unique_test.py
```

if you have already launched tests, you can use --skip_bina and --skip-cities after to avoid binarization

if data is loaded you may use NG to do request with jormun
```
# example with guichet-unique
http://localhost:9191/v1/coverage/guichet-unique/journeys?from=stop_area%3AOCE%3ASA%3A87686006&to=stop_area%3AOCE%3ASA%3A87751008&datetime=20120920T090000&
```

kirin docker allows to use realtime stimulation, the web service is callable with
```
http://localhost:9090
```

to post a COTS feed

```
curl -X POST 'http://localhost:5000/cots' -H 'Content-Type: application/json' -d <PATH/TO/my_cots.json>
```

3. create reference

Must to have no references before new with the same name.

```
# in artemis/artemis
CONFIG_FILE=/home/bbrisset/dev/artemis/artemis/dev_settings.py pytest -k guichet_unique_test.py --create_ref
# Check refs after
```

4. load data within NG

Comment a test and add pass
run the test

```
# in artemis/artemis
CONFIG_FILE=/home/bbrisset/dev/artemis/artemis/dev_settings.py pytest -k test_kirin_cots_trip_delay
```
after, request on navitia

## Run a PR on artemis on Jenkins

Jobs
- navitia_custom_pull_request_build
- deploy_navitia_on_artemis
- Artemis

<!--
--------------------------------------------------------------------------
-->

<!---
--------------------------------------------------------------------------
-->
## Tyr

Change parameters on a selected coverage

```
curl -X PUT -d 'param=val' url/v0/instances/coverage
```

View last dataset

```
url_tyr/v0/instances/covarage/last_datasets
```

View Tyr jobs

```
url_tyr/v0/jobs/coverage
```

View params

```
url_tyr/v0/instances/coverage
```

## Tyr-configurator

Overload parameters that you want to change

```
# in tyr-configurator/coverage.py
coverage_name = Coverage(
     name="coverage-name",
     param1=val1
     param2=val2
)
```
Check if parameters exist in tyr-configurator/tyr/coverage.py
Add coverage in tyr-configurator/{coverage} if it is necessary

<!---
--------------------------------------------------------------------------
-->

## benchmark

1. AB

```
ab -n 100 -c 1 -A token:  "url/v1/coverage/coverage-name/api?"
```

2. curl

```
curl "url/v1/coverage/coverage-name/api?" -H 'Authorization: token'
```

<!---
--------------------------------------------------------------------------
-->

<!---
--------------------------------------------------------------------------
-->


<!---
--------------------------------------------------------------------------
-->

## jormun config via tyr

```
# find url inside deployment conf
url/v0/instances
or
url/v0/instances/sitf
```

## Post to trigger Jenkins

```
# With parameters
http -v -f POST https://github:key@ci.navitia.io/job/receive_artifact_run_id_from_github/buildWithParameters github_run_id=1234
```
