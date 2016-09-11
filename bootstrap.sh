#!/bin/bash

# Wait For Debian Package Manager Lock
function waitForLock {
  i=0
  tput sc
  while fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
      case $(($i % 4)) in
          0 ) j="-" ;;
          1 ) j="\\" ;;
          2 ) j="|" ;;
          3 ) j="/" ;;
      esac
      tput rc
      echo -en "\r[$j] Waiting for other software managers to finish..."
      sleep 0.5
      ((i=i+1))
  done
}

waitForLock

# 16.04 Workaround?
sudo apt-get install apt-transport-https

# Puppet Modules Directory

# Docker Debian Sources # 14.04
echo deb http://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# NodeJs Sources
sudo curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
sudo apt-get install -y puppet
sudo apt-get install -y apparmor apparmor-profiles apparmor-utils
# apt-get install -y lxc-docker-1.7.1 # 14.04 version
sudo apt-get install -y docker.io

# Start Docker Image(s)
CONTAINER=db
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)
if [ "$RUNNING" == "false" ]; then
  sudo docker start $CONTAINER
fi
if [ "$RUNNING" == "" ]; then
  sudo docker run -d --name=$CONTAINER -p 5432:5432 -e USER="super" -e DB="yaas" -e PASS="postgres" -e POSTGRES_PASS="postgres" pennassurancesoftware/postgresql
fi

puppet module install --force puppetlabs-apt;
puppet module install --force garethr/docker;
puppet module install --force cyberious/apm
puppet module install --force jamesnetherton-google_chrome
