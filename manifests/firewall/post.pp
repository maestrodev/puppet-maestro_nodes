class maestro_nodes::firewall::post {


  firewall { "999 drop all other requests to ${ipaddress}":
    proto       => 'all',
    action      => 'drop',
    destination => [$ipaddress],
    before      => undef,
  }

}