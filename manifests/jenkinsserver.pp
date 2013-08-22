# A jenkins server configured with git plugin and configured to use the
# Archiva repository for Maven builds
class maestro_nodes::jenkinsserver(
  $user = 'jenkins',
  $group = 'jenkins',
  $version = undef,
  $port = '8181',
  $prefix = undef,
  $git_plugin_version = '1.4.0' ) {

  class { 'jenkins' :
    jenkins_user   => $user,
    jenkins_group  => $group,
    jenkins_port   => $port,
    jenkins_prefix => $prefix,
    version        => $version,
  }
  if defined(Package['java']) {
    Package['java'] -> Service['jenkins']
  }

  maven::settings { 'jenkins' :
    home                => "/var/lib/jenkins",
    user                => $user,
    default_repo_config => $maestro_nodes::repositories::default_repo_config,
    mirrors             => $maestro_nodes::repositories::mirrors,
    servers             => $maestro_nodes::repositories::servers,
    require             => [Class['maestro_nodes::repositories'], Package['jenkins']], # to know what the user/password is used in the repos
  } ->

  file { '/var/lib/jenkins/plugins':
      ensure => directory,
      owner => $user,
      group => $group,
      mode  => '0700',
      require => Package['jenkins']
  } ->
  wget::fetch {'git.hpi':
    source      => "http://updates.jenkins-ci.org/download/plugins/git/${git_plugin_version}/git.hpi",
    destination => '/var/lib/jenkins/plugins/git.hpi',
    notify      => Service['jenkins']
  }

}
