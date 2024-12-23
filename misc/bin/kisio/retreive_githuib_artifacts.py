#!/usr/bin/python
import json
import requests
import wget
import sys

WORKFLOW_NAME = "Build Navitia Packages"
CONNECTION_STRING = "https://USER:TOKEN@"
WORKFLOWS_URL = CONNECTION_STRING + "api.github.com/repos/CanalTP/navitia/actions/workflows"

# Find workflow id from Build Navitia Package
workflow_name = ""
print("[INFO] - call {}".format(WORKFLOWS_URL))
r = requests.get(WORKFLOWS_URL)
parsed_json = json.loads(r.text.encode('utf-8'))
workflow_id = -1
for workflow in parsed_json["workflows"]:
    if workflow["name"] == WORKFLOW_NAME:
        workflow_id = workflow["id"]
        workflow_name = workflow["name"]
        print("[INFO] - workflow id for {} is {}".format(workflow_name, workflow_id))
        break
if workflow_name == "":
    print("[ERROR] - workflow name={}, does not exist".format(WORKFLOW_NAME))
    sys.exit()

# Retreive artifacts link from the last run
artifacts_url = ""
runs_request = CONNECTION_STRING + "api.github.com/repos/CanalTP/navitia/actions/workflows/" + str(workflow_id) + "/runs"
print("[INFO] - call {}".format(runs_request))
r = requests.get(runs_request)
parsed_json = json.loads(r.text.encode('utf-8'))
total_count = parsed_json["total_count"]
for workflow_run in parsed_json["workflow_runs"]:
    if workflow_run["run_number"] == total_count:
        artifacts_url = workflow_run["artifacts_url"]
        run_id = workflow_run["id"]
        print("[INFO] - last run for {} is run id={}".format(WORKFLOW_NAME, run_id))
        break

# Download artifacts
print("[INFO] - call {}".format(artifacts_url))
artifacts_url = CONNECTION_STRING + artifacts_url.replace('https://', '')
r = requests.get(artifacts_url)
parsed_json = json.loads(r.text.encode('utf-8'))
if parsed_json["total_count"] == 0:
    print("[ERROR] - No artifacts available for run {}".format(run_id))
    print("[ERROR] - Artifacts : ]https://api.github.com/repos/CanalTP/navitia/actions/runs/{}/artifacts".format(run_id))
    sys.exit()
if parsed_json["total_count"] > 1:
    print("[ERROR] - There must be only one artifacts - run id {}".format(run_id))
    print("[ERROR] - Artifacts : ]https://api.github.com/repos/CanalTP/navitia/actions/runs/{}/artifacts".format(run_id))
    sys.exit()
zip_url = CONNECTION_STRING + parsed_json["artifacts"][0]["archive_download_url"].replace('https://', '')
filename = ""
print("[INFO] - download {}".format(zip_url))
filename = wget.download(zip_url, "navitia_debian_packages.zip")
print("")
print("[INFO] - File name {} downloaded".format(filename))

