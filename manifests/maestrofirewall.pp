class maestro_nodes::maestrofirewall {

  include firewall

  # Purge unmanaged firewall resources
  #
  # This will clear any existing rules, and make sure that only rules
  # defined in puppet exist on the machine
  resources { 'firewall':
    purge => true,
  }

  class { 'maestro_nodes::firewall::pre':
    before => Package['wget'],
  }
  class { 'maestro_nodes::firewall::post': }

  firewall { '020 allow http/https':
    proto  => 'tcp',
    port   => [80,443,8080],
    action => 'accept',
  }
  firewall { '030 allow stomp':
    proto  => 'tcp',
    port   => [61613],
    action => 'accept',
  }
}
