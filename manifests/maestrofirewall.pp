class maestro_nodes::maestrofirewall {

  include firewall

  # Purge unmanaged firewall resources
  #
  # This will clear any existing rules, and make sure that only rules
  # defined in puppet exist on the machine
  resources { 'firewall':
    purge => true,
  }

  Firewall {
    before  => Class['maestro_nodes::firewall::post'],
    require => Class['maestro_nodes::firewall::pre'],
  }

  include maestro_nodes::firewall::pre, maestro_nodes::firewall::post
}