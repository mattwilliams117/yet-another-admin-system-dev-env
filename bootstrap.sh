#!/bin/bash

# Puppet Modules Directory

# Docker Debian Sources
echo deb http://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver pgp.mit.edu --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# NodeJs Sources
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -

apt-get update
apt-get -y upgrade

# DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
apt-get install -y puppet
apt-get install -y apparmor apparmor-profiles apparmor-utils
apt-get install -y lxc-docker-1.7.1

# Start Docker Image(s)
CONTAINER=db
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)
if [ "$RUNNING" == "false" ]; then
  docker start $CONTAINER
fi
if [ "$RUNNING" == "" ]; then
  sudo docker run -d --name=$CONTAINER -p 5432:5432 -e USER="super" -e DB="yaas" -e PASS="postgres" -e POSTGRES_PASS="postgres" pennassurancesoftware/postgresql
fi

puppet module install --force puppetlabs-apt;
puppet module install --force garethr/docker;
puppet module install --force cyberious-apm
puppet module install --force jamesnetherton-google_chrome
