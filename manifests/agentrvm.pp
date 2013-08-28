class maestro_nodes::agentrvm(
  $agent_user = undef,
) {

  include maestro_nodes::agent

  # rvm needs to be included after other classes that install packages that rvm also installs
  include rvm

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
