# This class includes everything needed to install and configure a maestro server
class maestro_nodes::maestro($repo, $disabled = false) {

  # This hack is to get around hiera boolean shortcomings
  $enabled = $disabled ? { true => false, default => true}

  include maestro
  include maestro_nodes::metrics_repo

  # Maestro master server
  class { 'maestro::maestro':
    repo    => $repo,
    enabled => $enabled,
  }

  include maestro_nodes::database
  include activemq
  include activemq::stomp
  include maestro::plugins


}