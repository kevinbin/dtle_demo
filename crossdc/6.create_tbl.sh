#!/bin/bash
set -v
dex mysql-dc1 mysql -ppass -e 'create table demo.demo_tbl(a int primary key)'
dex mysql-dc2 mysql -ppass -e 'create table demo.demo_tbl(a int primary key)'