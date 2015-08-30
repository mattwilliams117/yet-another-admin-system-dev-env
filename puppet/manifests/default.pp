# What is an OS agnostic workstation.
Exec {
  path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }


class { "jdk_oracle":
  version  => "7",
  version_update => "67"
}

class { "maven::maven":
  version => "3.3.3"
}

class wrapper {
  anchor { 'wrapper::begin': }                                                               ->
  class { 'eclipse': method => 'download', release_name => 'luna', service_release => 'R' }  ->    # Eclipse
  class { 'eclipse::plugin::shelled': method => 'p2_director' }                              ->    # Puppet editor for eclipse
  class { 'eclipse::plugin::markdown': method => 'p2_director' }                             ->    # Markdown editor for eclipse
  class { 'eclipse::plugin::osgi': method => 'p2_director' }                                 ->    # M2E/OSGi Integration for eclipse
  anchor { 'wrapper::end': }
}


  
  
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
