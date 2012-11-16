class maestro_nodes::archivaserver(
  $port            = 8082,
  $maxmemory       = '256',
  $forwarded       = false,
  $application_url = "http://localhost:8082/archiva") {

  $central_repo_url = 'https://repo.maestrodev.com/archiva/repository/central') {

  postgresql::db{ 'archiva':
    user      => 'maestro',
    password  => $maestro_nodes::database::password,
    require   => [Class['postgresql::server'], Class['maestro_nodes::database']],
  } ->
  class { 'archiva':
    port            => $port,
    forwarded       => $forwarded,
    repo            => $maestro::repository::maestrodev,
    application_url => $application_url,
    archiva_jdbc    => $maestro_nodes::database::maestro_jdbc,
    users_jdbc      => $maestro_nodes::database::maestro_jdbc,
    jdbc_driver_url => $maestro_nodes::database::jdbc_driver_url,
    jetty_version   => 7,
    maxmemory       => '64',
  }
  file { "basic/archiva.xml":
    path    => "${archiva::home}/conf/archiva.xml",
    owner   => $archiva::user,
    group   => $archiva::group,
    mode    => 0644,
    content => template("maestro_nodes/archiva.xml.erb"),
    replace => false,
    require => File[$archiva::home],
    notify  => Service[$archiva::service],
  } 
}
