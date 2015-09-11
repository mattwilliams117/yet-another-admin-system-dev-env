# yet-another-admin-system-dev-env
Vagrant configuraiton for Yet Another Admin System development environment.

## Tools
* <del>Eclipse (with plugins)</del>
    **Plugins**
    * <del>OSGi Integration Plugin: http://repo1.maven.org/maven2/.m2e/connectors/m2eclipse-tycho/0.7.0/N/0.7.0.201309291400/</del>
    * <del>AspectJ Development Tools: http://download.eclipse.org/tools/ajdt/44/dev/update/</del>
    * <del>AspectJ M2E Configurer: http://dist.springsource.org/release/AJDT/configurator/</del>
    * <del>TestNG Plugin: http://beust.com/eclipse</del>
    * <del>Java Decompiler Plugin: Special instructions</del>
    * <del>buildhelper Maven Connector</del>
    * <del>m2e-apt Maven Connector</del>

* <del>Java Decompiler</del>
* <del>Git</del>
* <del>Docker</del>
* <del>Squirrel SQL (setup for database)</del>
* <del>Maven</del>
* <del>JDK(s)</del>


## Debugging
````
cd /vagrant/puppet
sudo puppet apply manifests/default.pp --debug --modulepath=modules --hiera_config=hiera.yaml --ordering=manifest
````

## Todo
1. <del>Setup Maven `settings.xml`</del>
2. <del>Provision Docker db</del>
5. Setup Database connections in Squirrel (with needed driver(s))
3. setup eclipse workspace
6. Setup Eclipse Preferences
4. Get Repositories?

