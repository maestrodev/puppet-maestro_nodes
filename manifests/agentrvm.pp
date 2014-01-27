class maestro_nodes::agentrvm(
  $agent_user = $maestro::params::agent_user,
) inherits maestro::params {

  include maestro_nodes::agent

  # install rubies from binaries
  Rvm_system_ruby {
    build_opts => ['--binary'],
  }

  # ensure rvm doesn't timeout finding binary rubies
  # the umask line is the default content when installing rvm if file does not exist
  file { '/etc/rvmrc':
    content => 'umask u=rwx,g=rwx,o=rx
                export rvm_max_time_flag=20',
    mode    => '0664',
    owner   => 'root',
    group   => 'rvm',
    before  => Class['rvm'],
  }

  class { 'rvm': }

  rvm::system_user { $agent_user:
    require => Class['maestro::params'],
  }

  class { 'maestro_nodes::rubygems': }
}
