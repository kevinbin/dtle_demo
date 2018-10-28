#!/bin/bash
set -v
curl -XDELETE "127.0.0.1:8191/v1/job/$1"