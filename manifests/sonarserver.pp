# Sonar server using postgres database
class maestro_nodes::sonarserver(
  $port = 8083,
  $db_password = $maestro_nodes::database::password) {

  postgresql::db{ 'sonar':
    user      => 'maestro',
    password  => $db_password,
    require   => [Class['postgresql::server'], Class['maestro_nodes::database']],
  } ->
  class { sonar:
    port => $port,
    jdbc => $maestro_nodes::database::sonar_jdbc,
  }
}
