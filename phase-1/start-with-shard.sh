#!/bin/bash -e

#
# Simple script ot start processes while specifying 
# some additional environment variables. In this case,
# we wanted to specify the shard that the process
# should start with.
#

PORT=$2
RACKUP=$3

SHARD=$1 bundle exec thin start -p $PORT -R $RACKUP