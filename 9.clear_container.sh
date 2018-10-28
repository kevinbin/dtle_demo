#!/bin/bash
set -v
docker stop mysql1 
docker rm mysql1
docker stop mysql2
docker rm mysql2
docker stop mysql3
docker rm mysql3
docker stop dtle
docker rm dtle
docker network rm dtle-net

docker stop mysql-dc1 
docker rm mysql-dc1
docker stop mysql-dc2
docker rm mysql-dc2
docker stop dtle-dc1
docker rm dtle-dc1
docker stop dtle-dc2
docker rm dtle-dc2
docker network rm dtle-net-dc1
docker network rm dtle-net-dc2
docker network rm dtle-net-public