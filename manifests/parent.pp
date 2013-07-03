# A typical parent node that can be reused
class maestro_nodes::parent() {

  group { "puppet":
    ensure => "present",
  }

  # Java
  file { "/etc/profile.d/set_java_home.sh":
    ensure  => present,
    content => 'export JAVA_HOME=/usr/lib/jvm/jre-openjdk',
    mode    => '0755',
  } ->
  exec { "/bin/sh /etc/profile": } 
  class { 'java':
    package => 'java-1.6.0-openjdk-devel',
  }

  case $::kernel {
   'Linux': {
     file { '/etc/motd':
         content => "Maestro 4\n"
     }     
     
     # NTP client
     class { 'ntp': }
    }
    default: {

    }
  }

  # Need epel for rvm installation and nginx
  stage { 'epel': }
  class { 'epel': stage => 'epel' }
}
