#!/bin/bash

CONTAINER=$1
if [ "$CONTAINER" == "" ]; then
  CONTAINER=db
fi

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)
if [ "$RUNNING" == "false" ]; then
  docker start $CONTAINER
fi
if [ "$RUNNING" == "" ]; then
  sudo docker run -d --name=$CONTAINER -p 5432:5432 -e USER="super" -e DB="yaas" -e PASS="postgres" -e POSTGRES_PASS="postgres" pennassurancesoftware/postgresql
fi
