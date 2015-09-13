# What is an OS agnostic workstation.
Exec {
  path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

package { 'docker.io': ensure => latest }
package { 'git': ensure => latest }

# class { "jdk_oracle":
#   version  => "7",
#   version_update => "67"
# }
package { ['openjdk-7-jdk','openjdk-7-jre', 'openjdk-7-jre-headless']: 
  ensure => latest,
}


include 'docker'

# sudo docker run -d --name=db -p 5432:5432 -e USER="super" -e DB="yaas" -e PASS="postgres" -e POSTGRES_PASS="postgres" pennassurancesoftware/postgresql
docker::run { 'db':
  image   => 'pennassurancesoftware/postgresql',
  env     => ['USER=super', 'DB=yaas', 'PASS=postgres', 'POSTGRES_PASS=postgres'],
  ports   => ['5432:5432'],
  # restart_service => true,
}




# Maven
$servers = [
  { id => "github", username => "pas-jenkins", password => "london10", },
  { id => "internal-nexus-repository", username => "jbc", password => "london10", },
  { id => "internal-nexus-snapshot-repository", username => "jbc",  password => "london10", },
  { id => "internal-nexus-sites-repository", username => "jbc", password => "london10", },
  { id => "internal-nexus-release-repository", username => "jbc", password => "london10", },
]
maven::settings { 'maven-user-settings' :
    servers => $servers,
    user => 'vagrant'
} ->
class { "maven::maven":
  version => "3.3.3"
}


# Java Decompiler
class java_decompiler {
  archive::download { 'jd-gui_1.4.0-0_all.deb':
    url              => 'https://github.com/java-decompiler/jd-gui/releases/download/v1.4.0/jd-gui_1.4.0-0_all.deb',
    checksum         => false,
    follow_redirects => true,
  } ->
  package { "java-decompiler":
    provider => dpkg,
    ensure   => latest,
    source   => "/usr/src/jd-gui_1.4.0-0_all.deb"
  }
}
include java_decompiler

# Squirrel SQL
include squirrel_sql


# Eclipse
include eclipse
include eclipse::plugin::shelled
include eclipse::plugin::osgi
include eclipse::plugin::aspectj
include eclipse::plugin::testng
include eclipse::plugin::m2e_buildhelper
include eclipse::plugin::m2e_apt
include eclipse::plugin::jd


  
# exec { 'fix-eclipse-memory1':
#   command => 'sed -i "s/^256m/1024m/" /opt/eclipse/eclipse.ini',
#   unless  => "grep -- '1024m' /opt/eclipse/eclipse.ini"
# }

# exec { 'fix-eclipse-memory2':
#   command => 'sed -i "s/^-XX:MaxPermSize=256m/-XX:MaxPermSize=1024m/" /opt/eclipse/eclipse.ini',
#   unless  => "grep -- '-XX:MaxPermSize=1024m' /opt/eclipse/eclipse.ini"
# }

# exec { 'fix-eclipse-memory3':
#   command => 'sed -i "s/^-Xmx512m/-Xmx1024m/" /opt/eclipse/eclipse.ini',
#   unless  => "grep -- '-Xmx1024m' /opt/eclipse/eclipse.ini"
# }
