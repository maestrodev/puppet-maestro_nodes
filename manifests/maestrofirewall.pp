class maestro_nodes::maestrofirewall {

  include firewall

  # Purge unmanaged firewall resources
  #
  # This will clear any existing rules, and make sure that only rules
  # defined in puppet exist on the machine
  resources { 'firewall':
    purge => true,
  }

  # rpm and wget runs sometimes between firewall commands and fails, package
  # will catch both cases since wget has a Package['wget'] requirement
  # TODO find a better way to express that wget::fetch and wget::authfetch depend on firewall
  include maestro_nodes::firewall::pre
  Class['maestro_nodes::firewall::post'] -> Package<| title != 'iptables' |>
  include maestro_nodes::firewall::post

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
