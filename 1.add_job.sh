#!/bin/bash
set -v
curl -H "Accept:application/json" -XPOST "http://127.0.0.1:8190/v1/jobs" -d @$1 -s | jq
