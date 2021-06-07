#!/bin/bash
# Written by Simon de Kraa <simon@technorabilia.com>

# vars
BASEDIR=/volume1/docker
BASEURL=https://raw.githubusercontent.com/technorabilia/docker-bits/main/lsio

# checks
[[ $# -ne 1 ]] &&
  echo "Provide one LinuxServer.io project name like e.g. 'sonarr'! Aborting." && exit 1

curl --silent --location --head --fail \
  $BASEURL/$1/run-once.sh --output /dev/null || \
  { echo "LinuxServer.io project '$1' does not exists! Aborting."; exit 1; }

[[ -d $BASEDIR/$1 ]] && \
  echo "Output directory already exists! Aborting." && exit 1

# create project dir
mkdir -p $BASEDIR/$1

# downloads
[[ -f $BASEDIR/docker-env.cfg ]] || \
  curl --silent --location $BASEURL/docker-env.cfg --output $BASEDIR/docker-env.cfg

curl --silent --location $BASEURL/$1/docker-compose.yaml --output $BASEDIR/$1/docker-compose.yaml

curl --silent --location $BASEURL/$1/run-once.sh --output $BASEDIR/$1/run-once.sh
( cd $BASEDIR/$1; . /$BASEDIR/$1/run-once.sh )
rm $BASEDIR/$1/run-once.sh

# readme
echo The following directories and files have been created:
echo "   $BASEDIR/docker-env.cfg"
find $BASEDIR/$1 | pr -T -o 3
echo
echo Application setup:
echo 1. Review the global settings in $BASEDIR/docker-env.cfg:
pr -T -o 3 $BASEDIR/docker-env.cfg | tail -n +2
echo 2. Review $BASEDIR/$1/docker-compose.yaml
echo 3. Create and start the application with:
echo "   $ cd $BASEDIR/$1"
echo "   $ sudo docker-compose up -d"
echo 4. Stop and remove the application with:
echo "   $ cd $BASEDIR/$1"
echo "   $ sudo docker-compose down"
