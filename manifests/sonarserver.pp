class maestro_nodes::sonarserver(
  $db_password = $maestro_nodes::database::password) {

  postgresql::db{ 'sonar':
    user      => 'maestro',
    password  => $db_password,
    require   => [Class['postgresql::server'], Class['maestro_nodes::database']],
  } ->
  class { sonar:
    port => 8083,
    jdbc => $maestro_nodes::database::sonar_jdbc,
  }
}
