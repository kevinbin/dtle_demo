#!/bin/bash
set -v 
curl -XGET "127.0.0.1:8191/v1/jobs" -s | jq '.[] | .Name + " " + .ID + " " + .Status'