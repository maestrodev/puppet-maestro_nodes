class maestro_nodes::firewall::post {

  anchor { 'firewall-post':
    require => Anchor['firewall-pre'], # this is kindof duplicated but needed
  } ->

  firewall { "999 drop all other requests to ${ipaddress}":
    proto       => 'all',
    action      => 'drop',
    destination => [$ipaddress],
    before      => undef,
  }

}
