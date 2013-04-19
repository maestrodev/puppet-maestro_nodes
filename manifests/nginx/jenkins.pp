class maestro_nodes::nginx::jenkins(
  $jenkins_port = $maestro_nodes::jenkinsserver::port,
  $hostname = $maestro_nodes::nginx::hostname,
  $ssl = $maestro_nodes::nginx::ssl,
) {
  nginx::resource::location { 'jenkins_app':
    ensure => present,
    location => '/jenkins',
    proxy => 'http://jenkins_app',
    vhost => $hostname,
    ssl => $ssl,
    ssl_only => $ssl,
  }

  nginx::resource::upstream { 'jenkins_app':
    ensure => present,
    members => "localhost:$jenkins_port",
  }
}
