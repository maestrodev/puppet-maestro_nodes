class maestro_nodes::sonarserver() {

  postgresql::db{ 'sonar':
    user      => 'maestro',
    password  => $maestro_nodes::database::password,
    require   => [Class['postgresql::server'], Class['maestro_nodes::database']],
  } ->
  class { sonar:
    port => 8083,
    jdbc => $maestro_nodes::database::sonar_jdbc,
  }
}
