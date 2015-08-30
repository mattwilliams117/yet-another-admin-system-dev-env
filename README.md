# yet-another-admin-system-dev-env
Vagrant configuraiton for Yet Another Admin System development environment.

## Tools
* Java Decompiler
* Eclipse (with plugins)
    **Plugins**
    * <del>OSGi Integration Plugin: http://repo1.maven.org/maven2/.m2e/connectors/m2eclipse-tycho/0.7.0/N/0.7.0.201309291400/</del>
    * AspectJ Development Tools: http://download.eclipse.org/tools/ajdt/44/dev/update/
    * AspectJ M2E Configurer: http://dist.springsource.org/release/AJDT/configurator/
    * TestNG Plugin: http://beust.com/eclipse
    * Java Decompiler Plugin: Special instructions
    * buildhelper Maven Connector
    * m2e-apt Maven Connector
    
    **Preferences**
    
* Git
* Docker
* Get Repositories?
* Squirrel SQL (setup for database)
* <del>Maven</del>
* <del>JDK(s)</del>


## Debugging
````
cd /vagrant/puppet
sudo puppet apply manifests/default.pp --debug --modulepath=modules
````

## Todo
1. Setup Maven `settings.xml`
