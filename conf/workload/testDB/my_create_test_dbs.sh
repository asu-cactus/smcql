#!/bin/bash

#run from smcql home, which contains src/ 
path=$(pwd)
echo "Using test data from $path"

if [ ! -d "$path/src" ]; then
  echo "Running from incorrect directory. Please run from project home directory."
  exit
fi

echo "Creating test database..."

dbPrefix='smcql_testDB'
dropdb $dbPrefix
createdb $dbPrefix
psql $dbPrefix -f $path/conf/workload/testDB/my_test_schema.sql

for i in 1 2
do
    dbName=$dbPrefix'_site'$i
    dropdb $dbName
    createdb $dbName

    psql $dbName -f $path/conf/workload/testDB/my_test_schema.sql
    psql $dbName -c "\COPY surveillance FROM '$path/conf/workload/testDB/$i/surveillance.csv' DELIMITER ',' CSV"
    psql $dbName -c "\COPY passenger FROM '$path/conf/workload/testDB/$i/passenger.csv' DELIMITER ',' CSV"

    val=$i
    if (($val == 1)); then
        psql $dbName -c "\COPY remote_surveillance FROM '$path/conf/workload/testDB/2/surveillance.csv' DELIMITER ',' CSV"
    else
        psql $dbName -c "\COPY remote_surveillance FROM '$path/conf/workload/testDB/1/surveillance.csv' DELIMITER ',' CSV"
    fi
done

psql -lqt | cut -d \| -f 1 | grep -qw $dbPrefix
res0=$?
psql -lqt | cut -d \| -f 1 | grep -qw $dbPrefix'_site1'
res1=$?
psql -lqt | cut -d \| -f 1 | grep -qw $dbPrefix'_site2'
res2=$?

if (($res0 == 0)) && (($res1 == 0)) && (($res2 == 0)); then
    exit 0
else
    exit 1
fi
