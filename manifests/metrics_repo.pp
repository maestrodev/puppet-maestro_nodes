class maestro_nodes::metrics_repo{

  class { 'mongodb':
    enable_10gen => true,
  }

  $statsd_config = { 'mongoHost' => '"localhost"',
    'mongoMax' => 2160
  }
  $backends =   [ 'mongo-statsd-backend' ]

  class { 'nodejs::params':
    version => '0.8.19',
  } ->
  class { 'nodejs':

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