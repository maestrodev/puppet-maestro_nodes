class maestro_nodes::maestrofirewall {

  include firewall

  # Purge unmanaged firewall resources
  #
  # This will clear any existing rules, and make sure that only rules
  # defined in puppet exist on the machine
  resources { 'firewall':
    purge => true,
  }

  include maestro_nodes::firewall::pre, maestro_nodes::firewall::post
}
