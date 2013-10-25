class maestro_nodes::maestrofirewall {

  # Purge unmanaged firewall resources
  #
  # This will clear any existing rules, and make sure that only rules
  # defined in puppet exist on the machine
  resources { 'firewall':
    purge => true,
  }

  # ensure purge happens after basic firewall rules are set
  # https://github.com/puppetlabs/puppetlabs-firewall/issues/239#issuecomment-26443579

  class{ ['maestro_nodes::firewall::pre', 'firewall', 'maestro_nodes::firewall::post']:
    before => Resources['firewall'],
  }

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
