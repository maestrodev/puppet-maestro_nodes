class maestro_nodes::metrics_repo{

  include nodejs


  class { 'mongodb':
    enable_10gen => true,
  }

  # Mongo backend is disabled temporarily due to an
  # unexplained bug that crashes the statsd daemon.
  #  $statsd_config = { 'mongoHost' => '"localhost"',
  #    'mongoMax' => 2160
  #  }
  #  $backends =   [ 'mongo-statsd-backend' ]

  $statsd_config = { }
  $backends = [ ]
  

#  package { 'mongo-statsd-backend':
#    ensure   => present,
#    provider => npm,
#  } ->
  class { 'statsd':
    backends => $backends,
    config => $statsd_config,
  }


}