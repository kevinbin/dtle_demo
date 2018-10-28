#!/bin/bash
set -v
dex mysql1 mysql -ppass -e 'create table demo.tbl1(a int primary key);insert demo.tbl1 value(1)'
#dex mysql2 mysql -ppass -e 'create table demo.tbl2(a int primary key);insert demo.tbl2 value(2)'
#dex mysql3 mysql -ppass -e 'create table demo.tbl3(a int primary key);insert demo.tbl3 value(1),(2),(3),(4),(5)'
