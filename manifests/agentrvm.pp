class maestro_nodes::agentrvm(
  $agent_user = $maestro::params::agent_user,
) {
  include rvm

  # currently missing from puppet-rvm's list of dependencies
  package { [ 'libyaml-devel', 'libffi-devel', 'libtool', 'bison' ]:
    ensure => installed,
  } ->
  rvm::system_user { $agent_user: } ->
  rvm_system_ruby { 'ruby-1.8.7-p352':
    ensure      => 'present',
    default_use => true,
    require     => Package['git'],
  }
}
