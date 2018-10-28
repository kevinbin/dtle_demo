#!/bin/bash
set -v
curl -XDELETE "127.0.0.1:8190/v1/job/$1"