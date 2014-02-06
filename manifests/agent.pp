# A Maestro agent node with:
# git, subversion, maven, ant, ivy, rake and rubygems

class maestro_nodes::agent(
  $repo = $maestro::params::repo,
  $agent_user = $maestro::params::agent_user,
  $agent_group = $maestro::params::agent_group,
  $agent_user_home = $maestro::params::agent_user_home,
  $version   = undef,
  $maxmemory = '128',
  $maven_properties = undef) inherits maestro_nodes::repositories {

  case $::osfamily {
    'RedHat': {
      ensure_packages(['ruby-json']) # needed for facter to output json
    }
    default: {
    }
  }

  class { 'maestro::agent':
    repo          => $repo,
    agent_version => $version,
    maxmemory     => $maxmemory,
  }
  if defined(Package['java']) {
    Package['java'] -> Service['maestro-agent']
  }

  # Git
  class { git: } ->
  git::resource::config { "agent-gitconfig":
    user     => $agent_user,
    group    => $agent_group,
    root     => $agent_user_home,
    email    => 'info@maestrodev.com',
    realname => 'MaestroDev Demonstration',
  }
  # github.com ssh key
  sshkey { 'github.com':
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==',
  }
  # need to work around https://tickets.puppetlabs.com/browse/PUP-1177
  # /etc/ssh/ssh_known_hosts has bad permissions
  case $::kernel {
    'Linux': {
      class { 'ssh::client': }
    }
    default: {
    }
  }

  # Subversion
  class { 'svn': }

  # Maven
  class {'maven::maven':
    version => '3.0.4',
  } ->
  maven::settings { $agent_user :
    home                => $agent_user_home,
    user                => $agent_user,
    default_repo_config => $maestro_nodes::repositories::default_repo_config,
    mirrors             => $maestro_nodes::repositories::mirrors,
    servers             => $maestro_nodes::repositories::servers,
    properties          => $maven_properties,
    require             => [Class['maestro_nodes::repositories']],
  }

  # Ant
  class { 'ant': }
  class { 'ant::ivy': }
  class { 'ant::tasks::maven': }
  class { 'ant::tasks::sonar': }
  file { "ant.xml":
    path    => "${agent_user_home}/ant.xml",
    owner   => $agent_user,
    group   => $agent_group,
    mode    => 755,
    content => template("maestro_nodes/ant.xml.erb")
  }

  # Rake
  package { 'rake':
    provider => gem,
    ensure => installed,
  }

  # server_key for autoconnect and autoactivate
  file { '.maestro':
    ensure  => directory,
    path    => "${agent_user_home}/.maestro", 
    owner   => $agent_user,
    group   => $agent_group,
    mode    => 700,
  } ->
  file { 'server.key':
    content => 'server_key',
    path    => "${agent_user_home}/.maestro/server.key",
    owner   => $agent_user,
    group   => $agent_group,
    mode    => 600,
  }

  # ssh keys for cloud provisioning
  if !defined(File["${agent_user_home}/.ssh"]) {
    file { "${agent_user_home}/.ssh":
      ensure => directory,
      owner  => $agent_user,
      group  => $agent_group,
      mode   => 0700,
    }
  }
  
  ssh_keygen { $agent_user :
    home => $agent_user_home,
    require => File["${agent_user_home}/.ssh"],
  }

  # puppetforge credentials
  class { 'maestro_nodes::puppetforge': }
}
