#!/bin/bash
set -v
docker exec -it mysql-dc1 mysql -ppass -e "show master status"
docker exec -it mysql-dc2 mysql -ppass -e "show master status"