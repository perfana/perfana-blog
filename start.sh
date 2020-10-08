#!/bin/bash

source common.sh

PAUSE=10

echo "Starting Mongo cluster..."
docker-compose --compatibility up -d --remove-orphans mongo{1,2,3}

echo "Configuring Mongo replica-set..."
sleep 1
$DOCKER_CMD run -ti --rm -v $CONFIG_FILE:/init-mongo.js --net perfana-demo_perfana mongo:4.4-rc /usr/bin/mongo --host mongo1 --port 27011 /init-mongo.js

echo "Sleeping for ${PAUSE} secs to give Mongo a chance to start the replicaset..."
sleep ${PAUSE}

echo "Bringing up the rest of the Perfana test environment..."
docker-compose --compatibility up -d perfana-fixture
docker-compose --compatibility up -d mariadb

sleep ${PAUSE}

docker-compose --compatibility up -d

echo "Done!"

