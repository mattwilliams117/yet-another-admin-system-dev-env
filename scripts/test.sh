#!/bin/bash
mkdir -p ~/git
cd ~/git
rm -Rf yet-another-admin-system
git clone https://jeromebridge:Equisoft001@github.com/jeromebridge/yet-another-admin-system.git
git clone https://jeromebridge:Equisoft001@github.com/jeromebridge/yet-another-admin-system-boot.git
## wget -P /opt/eclipse/dropins/ https://github.com/snowch/test.myapp/raw/master/test.myapp_1.0.0.jar

cd yet-another-admin-system
mvn eclipse:clean eclipse:eclipse


# IMPORTS=$(find ${CARBON_SRC} -type f -name .project)
# for item in ${IMPORTS[*]};
# do
#    IMPORT="$(dirname $item)/"
#    echo "Importing ${IMPORT}"
#
#    # perform the import
#    eclipse -nosplash -application test.myapp.App -data /home/vagrant/workspace/ws-100 -import $IMPORT
# done

# http://download.eclipse.org/tools/cdt/releases/8.6
##   org.eclipse.cdt.feature.group
##   org.eclipse.cdt.sdk.feature.group
# eclipse -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -import ~/git/yet-another-admin-system/spring-aspects-osgi -data /home/vagrant/workspace/ws-101 -build all -cleanBuild all


# M2E
# http://download.eclipse.org/technology/m2e/releases
#     org.eclipse.m2e.feature.feature.group
#     org.eclipse.m2e.logback.feature.feature.group

# M2E AsjpectJ configurator
# http://dist.springsource.org/release/AJDT/configurator/
#     org.maven.ide.eclipse.ajdt.feature.feature.group
