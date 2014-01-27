class maestro_nodes::agentrvm(
  $agent_user = $maestro::params::agent_user,
) inherits maestro::params {

  include maestro_nodes::agent

  # install rubies from binaries
  Rvm_system_ruby {
    build_opts => ['--binary'],
  }

  # ensure rvm doesn't timeout finding binary rubies
  class { 'rvm::rvmrc':
    max_time_flag => 20,
  }
  class { 'rvm': }

  rvm::system_user { $agent_user:
    require => Class['maestro::params'],
  }

  class { 'maestro_nodes::rubygems': }
}
