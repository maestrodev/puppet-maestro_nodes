class maestro_nodes::archivaserver(
  $central_repo_url = 'https://repo.maestrodev.com/archiva/repository/central') {
  class { 'archiva':
    port            => 8082,
    forwarded       => false,
    repo            => $maestro::repository::maestrodev,
    application_url => 'http://localhost:8082/archiva',
    archiva_jdbc    => $maestro_nodes::database::maestro_jdbc,
    users_jdbc      => $maestro_nodes::database::maestro_jdbc,
    jdbc_driver_url => $maestro_nodes::database::jdbc_driver_url,
    jetty_version   => 7,
    maxmemory       => '64',
    require         => [Class['database'], Postgres::Createdb['archiva']],
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
