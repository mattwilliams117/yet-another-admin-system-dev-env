#!/bin/bash

# Docker Debian Sources
echo deb http://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver pgp.mit.edu --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

apt-get update

# DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
apt-get install -y puppet
apt-get install -y apparmor apparmor-profiles apparmor-utils
apt-get install -y lxc-docker-1.7.1

# Start Docker Image(s)
./start-docker-db.sh


puppet module install --force puppetlabs-apt;
puppet module install --force garethr/docker;
