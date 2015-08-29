# What is an OS agnostic workstation.
Exec {
  path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

class { "jdk_oracle":
  version  => "7",
  version_update => "67",
}

class { "maven::maven":
  version => "3.3.2"
}

class { 'eclipse':
    method          => 'download',
    release_name    => 'luna',
    service_release => 'R'
  } ->
  # Puppet editor for eclipse
  # class { 'eclipse::plugin::geppetto': method => 'p2_director', } # ->
  # Eclipse egit
  #class { 'eclipse::plugin::egit': method => 'p2_director', } ->
  # Edit shell scripts from within eclipse
  class { 'eclipse::plugin::shelled': method => 'p2_director', } ->
  # # yaml editor for eclipse
  #class { 'eclipse::plugin::yedit': method => 'p2_director', } ->
  # # Markdown editor for eclipse
  class { 'eclipse::plugin::markdown': method => 'p2_director', } # ->
  # Ruby Editor for eclipse
  #class { 'eclipse::plugin::dltk::ruby': } ->
  #class { 'eclipse::plugin::colortheme': method => 'p2_director', }
  
  
exec { 'fix-eclipse-memory1':
  command => 'sed -i "s/^256m/1024m/" /opt/eclipse/eclipse.ini',
  unless  => "grep -- '1024m' /opt/eclipse/eclipse.ini"
}

exec { 'fix-eclipse-memory2':
  command => 'sed -i "s/^-XX:MaxPermSize=256m/-XX:MaxPermSize=1024m/" /opt/eclipse/eclipse.ini',
  unless  => "grep -- '-XX:MaxPermSize=1024m' /opt/eclipse/eclipse.ini"
}

exec { 'fix-eclipse-memory3':
  command => 'sed -i "s/^-Xmx512m/-Xmx1024m/" /opt/eclipse/eclipse.ini',
  unless  => "grep -- '-Xmx1024m' /opt/eclipse/eclipse.ini"
}
