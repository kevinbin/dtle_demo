#!/bin/bash
set -v
curl -XGET "127.0.0.1:8190/v1/nodes" -s | jq