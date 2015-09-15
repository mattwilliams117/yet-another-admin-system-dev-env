#!/bin/bash

# Start Docker Image(s)
# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`
CMD=$SCRIPTPATH/start-docker-db.sh
eval "$CMD"
# ./start-docker-db.sh

