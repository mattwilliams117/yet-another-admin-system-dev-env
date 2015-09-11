#!/bin/bash

apt-get update
apt-get install -y puppet

puppet module install --force garethr/docker;
