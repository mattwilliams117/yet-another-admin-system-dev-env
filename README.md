# yet-another-admin-system-dev-env
Vagrant configuraiton for Yet Another Admin System development environment.

## Tools
* Java Decompiler
* Eclipse (with plugins)
    **Plugins**
    * <del>OSGi Integration Plugin: http://repo1.maven.org/maven2/.m2e/connectors/m2eclipse-tycho/0.7.0/N/0.7.0.201309291400/</del>
    * <del>AspectJ Development Tools: http://download.eclipse.org/tools/ajdt/44/dev/update/</del>
    * <del>AspectJ M2E Configurer: http://dist.springsource.org/release/AJDT/configurator/</del>
    * <del>TestNG Plugin: http://beust.com/eclipse</del>
    * Java Decompiler Plugin: Special instructions
    * buildhelper Maven Connector
    * m2e-apt Maven Connector
    
    **Preferences**
    
* Git
* Docker
* Squirrel SQL (setup for database)
* <del>Maven</del>
* <del>JDK(s)</del>


## Debugging
````
cd /vagrant
sudo puppet apply manifests/default.pp --debug --modulepath=modules --hiera_config=hiera.yaml --ordering=manifest
````

## Todo
1. Setup Maven `settings.xml`
2. Start Docker db
3. setup eclipse workspace
4. Get Repositories?
