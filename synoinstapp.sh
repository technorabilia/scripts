#!/bin/bash
# Written by Simon de Kraa <simon@technorabilia.com>

# vars
BASEDIR=/volume1/docker
BASEURL=https://raw.githubusercontent.com/technorabilia/docker-bits/main/lsio

# checks
[[ $# -ne 1 ]] &&
  echo "Provide one LinuxServer.io project name like e.g. 'sonarr'! Aborting." && exit 1

if ! wget --quiet --spider $BASEURL/$1/docker-compose.yaml
then
  echo "LinuxServer.io project '$1' does not exists! Aborting." && exit 1
  exit 1
fi

[[ -d $BASEDIR/$1 ]] && \
  echo "Output directory already exists! Aborting." && exit 1
mkdir -p $BASEDIR/$1

# downloads
[[ -f $BASEDIR/docker-env.cfg ]] || \
  curl -sL $BASEURL/docker-env.cfg -o $BASEDIR/docker-env.cfg

curl -sL $BASEURL/$1/docker-compose.yaml -o $BASEDIR/$1/docker-compose.yaml

curl -sL $BASEURL/$1/run-once.sh -o $BASEDIR/$1/run-once.sh
(cd $BASEDIR/$1; . /$BASEDIR/$1/run-once.sh)
rm $BASEDIR/$1/run-once.sh

# readme
echo The following directories and files have been created:
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
