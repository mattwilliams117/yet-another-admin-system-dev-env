#!/bin/bash

echo "################################"
echo "# sudo apt install zlib1g-dev  #"
echo "################################"

sudo apt install zlib1g-dev

echo ""
echo "######################################"
echo "# sudo apt-get -y install virtualbox #"
echo "######################################"

sudo apt-get -y install virtualbox

echo ""
echo "###################################"
echo "# sudo apt-get -y install vagrant #"
echo "###################################"

sudo apt-get -y install vagrant

echo ""
echo "###############################################"
echo "# vagrant plugin install vagrant-hostsupdater #"
echo "###############################################"
echo vagrant plugin install vagrant-hostsupdater

vagrant plugin install vagrant-hostsupdater

echo ""
echo "###################################################"
echo "# vagrant plugin install vagrant-librarian-puppet #"
echo "###################################################"
echo vagrant plugin install vagrant-hostsupdater

vagrant plugin install vagrant-librarian-puppet

echo ""
echo "#######################################"
echo "# vagrant plugin install vagrant-exec #"
echo "#######################################"
echo vagrant plugin install vagrant-exec

vagrant plugin install vagrant-exec

echo ""
echo "##############"
echo "# vagrant up #"
echo "##############"
FIRSTUP='firstup' vagrant up

vagrant exec "sudo add-apt-repository -y ppa:webupd8team/atom"

echo ""
echo "#####################"
echo "# vagrant provision #"
echo "#####################"
vagrant provision
