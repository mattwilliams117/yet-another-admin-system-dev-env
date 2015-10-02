#!/bin/bash
# This script depends on eclipse being installed to
# /home/vagrant/eclipse

# Manual
# git clone https://github.com/jeromebridge/yet-another-admin-system.git
# wget -P /opt/eclipse/dropins/ https://github.com/snowch/test.myapp/raw/master/test.myapp_1.0.0.jar

set -e
set -x

if [ -f /etc/developer_provisioned_date ]
then
   echo "Stratos developer already provisioned so exiting."
   exit 0
fi

# must be build with tests - see:
# http://wso2-oxygen-tank.10903.n7.nabble.com/Dev-Platform-build-failure-4-1-2-patch-release-td77798.html
sudo -i -u vagrant \
   mvn -B -f $CARBON_SRC/product-releases/chunk-05/pom.xml \
   -s $MAVEN_SETTINGS \
   -l /vagrant/log/mvn_clean_install.log \
   clean install \
   --fail-never

#####################
# maven eclipse setup
#####################

# perform mvn eclipse:eclipse

sudo -i -u vagrant \
   $M2_HOME/bin/mvn -B -f $CARBON_SRC/product-releases/chunk-05/pom.xml \
   -s $MAVEN_SETTINGS \
   -l /vagrant/log/mvn_eclipse_eclipse.log \
   -D downloadSources=true \
   eclipse:eclipse

# we need an eclipse plugin that will perform the headless import
# of projects into the workspace

sudo -i -u vagrant \
   wget -P /home/vagrant/eclipse/dropins/ \
      https://github.com/snowch/test.myapp/raw/master/test.myapp_1.0.0.jar

# get all the directories that can be imported into eclipse and append them
# with '-import'

IMPORTS=$(find ${CARBON_SRC} -type f -name .project)

# Although it is possible to import multiple directories with one
# invocation of the test.myapp.App, this fails if one of the imports
# was not successful.  Using a for loop is slower, but more robust
for item in ${IMPORTS[*]};
do
   IMPORT="$(dirname $item)/"
   echo "Importing ${IMPORT}"

   # perform the import
   sudo -i -u vagrant \
      /home/vagrant/eclipse/eclipse -nosplash \
      -application test.myapp.App \
      -data /home/vagrant/workspace \
      -import $IMPORT
done

# add the M2_REPO variable to the workspace

sudo -i -u vagrant \
   $M2_HOME/bin/mvn -B -f $CARBON_SRC/pom.xml \
   -s $MAVEN_SETTINGS \
   -l /vagrant/log/mvn_eclipse_configure_workspace.log \
   -Declipse.workspace=/home/vagrant/workspace/ \
   eclipse:configure-workspace


date > /etc/developer_provisioned_date
