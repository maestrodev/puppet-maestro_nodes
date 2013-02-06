class maestro_nodes::metrics_repo{
  
  
  class { 'mongodb':
    enable_10gen => true,
  }
  
  $statsd_config = { 'mongoHost' => '"localhost"',
                     'mongoMax' => 2160
                   }
  
  class { 'nodejs':
  
  } ->
  class { 'statsd':
    backends => [ 'mongo-statsd-backend' ],
    config => $statsd_config,
  } ->
  package { 'mongo-statsd-backend':
      ensure   => present,
      provider => npm,
  }

}