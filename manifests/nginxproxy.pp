class maestro_nodes::nginxproxy(
  $hostname = $::fqdn,
  $maestro_port = $maestro::maestro::port,
  $ssl = false,
  $ssl_cert = undef,
  $ssl_key = undef,
) {

  yumrepo { "epel":
    name        => 'epel',
    baseurl     => absent,
    enabled     => 1,
    mirrorlist  => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch',
    gpgcheck    => 0,
    before      => Package[nginx],
  }

  include nginx

  if $ssl == true {
    $port = '443'

    file { '/etc/nginx/conf.d/default.conf':
      ensure => present,
      source => "puppet:///modules/maestro_nodes/nginx/default.conf",
      notify => Service[nginx],
      require => Package[nginx],
    }
  } else {
    $port = '80'

    file { '/etc/nginx/conf.d/default.conf':
      ensure => absent,
      notify => Service[nginx],
      require => Package[nginx],
    }
  }

  nginx::resource::vhost { $hostname:
    ensure => present,
    ssl => $ssl,
    listen_port => $port,
    ssl_cert => $ssl_cert,
    ssl_key => $ssl_key,
    proxy => 'http://maestro_app',
  }

  nginx::resource::upstream { 'maestro_app':
    ensure => present,
    members => ["localhost:$maestro_port"],
  }
}
