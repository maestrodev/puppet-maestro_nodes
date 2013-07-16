class maestro_nodes::metrics_repo{

  class { 'mongodb':
    enable_10gen => true,
  }

  $statsd_config = { 'mongoHost' => '"localhost"',
    'mongoMax' => 2160
  }
  $backends =   [ 'mongo-statsd-backend' ]

  class { 'nodejs':
    manage_repo => true,
  } ->
  package { 'mongo-statsd-backend':
    ensure   => present,
    provider => npm,
  } ->
  class { 'statsd':
    ensure   => '0.4.0',
    backends => $backends,
    config   => $statsd_config,
  }

}
