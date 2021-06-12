#!/bin/bash
# Written by Simon de Kraa <simon@technorabilia.com>

# vars
BASEDIR=${BASEDIR:-/volume1/docker}
BASEURL=${BASEURL:-https://raw.githubusercontent.com/technorabilia/docker-bits/main/lsio}

# checks
[ $# -ne 1 ] &&
  echo -e "Get LinuxServer.io application docker-compose configuration.\n
Usage:
  $(basename $0) <application>\n
Application list at https://fleet.linuxserver.io/.\n" && exit 1

[ ! -d $BASEDIR/. ] && \
  echo "Base directory $BASEDIR does not exist." && exit 1

curl --silent --location --head --fail \
  $BASEURL/$1/run-once.sh --output /dev/null || \
  { echo "Application $1 does not exist."; exit 1; }

[ -d $BASEDIR/$1 ] && \
  echo "Directory $BASEDIR/$1 already exists." && exit 1

# create project dir
mkdir -p $BASEDIR/$1

# downloads
[ -f $BASEDIR/docker-env.cfg ] || \
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
pr -T -o 3 $BASEDIR/docker-env.cfg
echo 2. Review $BASEDIR/$1/docker-compose.yaml
echo 3. Create and start the application with:
echo "   $ cd $BASEDIR/$1"
echo "   $ sudo docker-compose up -d"
echo 4. Stop and remove the application with:
echo "   $ cd $BASEDIR/$1"
echo "   $ sudo docker-compose down"
