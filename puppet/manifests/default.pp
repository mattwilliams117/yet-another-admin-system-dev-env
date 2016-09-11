# What is an OS agnostic workstation.
Exec { path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

# Apt
include apt
exec { "apt-get update":
    command => "sudo /usr/bin/apt-get update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

# Java
exec { "add-java-7-apt":
  command => "sudo add-apt-repository -y ppa:openjdk-r/ppa; sudo apt-get update"
}
package { ['openjdk-7-jdk','openjdk-7-jre', 'openjdk-7-jre-headless']:  ensure => latest, require  => Exec['add-java-7-apt', 'apt-get update'], }
package { "visualvm":  ensure  => latest }

# Gimp
package { "gimp":  ensure  => latest, require  => Exec['apt-get update'], }

# Meld
package { "meld":  ensure  => latest, require  => Exec['apt-get update'], }

# Launch4J Supporting Libraries
# package { ['lib32z1', 'lib32ncurses5', 'lib32bz2-1.0']:  ensure => latest, } # 14.04 version
package { ['libz1:i386', 'libncurses5:i386', 'libbz2-1.0:i386', 'libstdc++6:i386']:  ensure => latest, } # 16.04 version

# Atom
exec { "add-atom-apt":
  command => "sudo add-apt-repository -y ppa:webupd8team/atom; sudo apt-get update"
}
#apt::ppa { 'ppa:webupd8team/atom': notify => Exec['apt_update'] }
package { "atom":  ensure  => latest, require  => Exec['add-atom-apt', 'apt-get update'], }

package { 'language-puppet':      ensure   => latest, provider => apm, require => Package['atom'], }
package { 'linter':               ensure   => latest, provider => apm, require => Package['atom'], }
package { 'linter-eslint':        ensure   => latest, provider => apm, require => Package['atom'], }
package { 'node-debugger':        ensure   => latest, provider => apm, require => Package['atom'], }
package { 'mocha-test-runner':    ensure   => latest, provider => apm, require => Package['atom'], }
package { 'react':                ensure   => latest, provider => apm, require => Package['atom'], }
package { 'xml-formatter':        ensure   => latest, provider => apm, require => Package['atom'], }
package { 'eclipse-keybindings':  ensure   => latest, provider => apm, require => Package['atom'], }

exec { 'apm install react xml-formatter': }

# NodeJS
exec { "nodejs dependency":
    command => "sudo apt-get -y install libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev build-essential g++"
}
package { "nodejs":  ensure  => latest, require  => Exec['nodejs dependency'], }

# Chrome
include 'google_chrome'

# Rultor
package { 'gpgv2':  ensure  => latest, require  => Exec['apt-get update'], }
package { 'rultor': ensure => 'installed', provider => 'gem', }

# Screencasts
package { "imagemagick":  ensure  => latest, require  => Exec['apt-get update'], }
package { "mplayer":  ensure  => latest, require  => Exec['apt-get update'], }
package { "gtk-recordmydesktop":  ensure  => latest, require  => Exec['apt-get update'], }

package { "byzanz":  ensure  => latest, require  => Exec['apt-get update'], }

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
class { "squirrel_sql":
  aliases => [
    { name => "LOCAL", url => "jdbc:postgresql://127.0.0.1/yaas", user => "super", password => "postgres" }
  ]
}

# Eclipse
include eclipse
include eclipse::plugin::shelled
include eclipse::plugin::osgi
include eclipse::plugin::aspectj
include eclipse::plugin::testng
include eclipse::plugin::m2e
include eclipse::plugin::m2e_aspectj
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
