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

docker network create dtle-net

docker run --name mysql1 -e MYSQL_ROOT_PASSWORD=pass -e MYSQL_ROOT_HOST=% -e MYSQL_DATABASE=demo -p 33061:3306 --network=dtle-net -d mysql/mysql-server:5.7 --gtid-mode=ON --enforce-gtid-consistency=1 --log-bin=bin --server-id=1
docker run --name mysql2 -e MYSQL_ROOT_PASSWORD=pass -e MYSQL_ROOT_HOST=% -e MYSQL_DATABASE=demo -p 33062:3306 --network=dtle-net -d mysql/mysql-server:5.7 --gtid-mode=ON --enforce-gtid-consistency=1 --log-bin=bin --server-id=2
docker run --name mysql3 -e MYSQL_ROOT_PASSWORD=pass -e MYSQL_ROOT_HOST=% -e MYSQL_DATABASE=demo -p 33063:3306 --network=dtle-net -d mysql/mysql-server:5.7 --gtid-mode=ON --enforce-gtid-consistency=1 --log-bin=bin --server-id=3


docker run --name dtle -p 8190:8190 --network=dtle-net -d actiontech/dtle
