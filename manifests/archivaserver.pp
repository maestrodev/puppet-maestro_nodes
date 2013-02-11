# Apache Archiva configured with a Postgres database and some default repositories
class maestro_nodes::archivaserver(
  $port            = 8082,
  $maxmemory       = '256',
  $forwarded       = false,
  $application_url = "http://localhost:8082/archiva",
  $db_password     = $maestro_nodes::database::password,
  $mail_from       = $maestro_nodes::mail::mail_from) {

  $central_repo_url = 'https://repo.maestrodev.com/archiva/repository/central'

  postgresql::db{ 'archiva':
    user      => 'maestro',
    password  => $db_password,
    require   => [Class['postgresql::server'], Class['maestro_nodes::database']],
  } ->
  class { 'archiva':
    version         => "1.4-M1-maestro-3.4.3.2",
    port            => $port,
    forwarded       => $forwarded,
    repo            => $maestro::repository::maestrodev,
    application_url => $application_url,
    archiva_jdbc    => $maestro_nodes::database::maestro_jdbc,
    users_jdbc      => $maestro_nodes::database::maestro_jdbc,
    jdbc_driver_url => $maestro_nodes::database::jdbc_driver_url,
    jetty_version   => 7,
    manage_user     => hiera('archiva::manage_user', true),
    maxmemory       => '64',
    mail_from       => $mail_from,
    require         => Class['maestro::repository'],
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
