#!/usr/bin/env bash
# Scripts for creating AIR (AI Routing) application with docker

# Step 0: Global ENV variables definition
echo "===> Step 0: Global ENV variables definition"
PG_DATA_VOL=pgdata
PG_USER=luliu
PG_PASS=luliu
PG_DBNAME=tracksdb
DB_CONTAINER_NAME=tracksdb
PG_VERSION=9.6-2.4
export PGPASSWORD=$PG_PASS
export AIR_NETWORK=airnet

# Step 1: Cleanup existing resources
echo "===> Step 1: Cleanup existing resources"
docker-compose down --rmi all
docker stop tracksdb
docker rm tracksdb
docker volume rm $PG_DATA_VOL
docker network rm $AIR_NETWORK

# Step 2: Create volume for postgis
echo "===> Step 2: Create volume for postgis"
docker volume create $PG_DATA_VOL

# Step 3: Create a dedicated network for all the services
echo "===> Step 3: Create a dedicated network for all the services"
docker network create $AIR_NETWORK

# Step 4: Create a postgis container and populate data
echo "===> Step 4: Create a postgis container and populate data"
docker run -d \
    --name=$DB_CONTAINER_NAME \
    -e POSTGRES_USER=$PG_USER \
    -e POSTGRES_PASS=$PG_PASS \
    -e POSTGRES_DBNAME=$PG_DBNAME \
    -e ALLOW_IP_RANGE=0.0.0.0/0 \
    -p 5432:5432 \
    -v $PG_DATA_VOL:/var/lib/postgresql \
    --restart=always \
    kartoza/postgis:$PG_VERSION

sleep 20s

gunzip -c db_dump/tracksdb.gz | psql $PG_DBNAME -h localhost -U $PG_USER -p 5432

# Step 5: Launch the services with docker-compose
echo "===> Step 5: Launch the services with docker-compose"
docker-compose up --build -d
