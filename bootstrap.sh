#!/bin/bash

apt-get update

# DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
apt-get install -y puppet
apt-get install -y apparmor apparmor-profiles apparmor-utils

puppet module install --force puppetlabs-apt;
puppet module install --force garethr/docker;
