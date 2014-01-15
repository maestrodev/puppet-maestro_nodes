class maestro_nodes::agentrvm(
  $agent_user = undef,
) {

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

  # rvm needs to be included after other classes that install packages that rvm also installs
  class { 'rvm': }

  # we can't use $maestro::params::agent_user until maestro_nodes::agent is declared
  $user = $agent_user ? {
    undef   => $maestro::params::agent_user,
    default => $agent_user,
  }

  rvm::system_user { $user:
    require => Class['maestro::params'],
  }

  # if we have a epel stage defined in parent nodes ensure it runs before installing rvm
  # as some rvm dependencies are in epel repositories
  if defined(Stage['epel']) and defined(Stage['rvm-install']) {
    Stage['epel'] -> Stage['rvm-install']
  }
}
