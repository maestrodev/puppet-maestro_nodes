# Node that can be imported in your site.pp

# Common configuration for Maestro Master and Agent nodes

node 'parent' {

  # Node that can be imported on your site.pp

  # Flag that enables "is_demo" on lucee config.
  # Note that this is only temporary as we'll be pushing demos into lucee via API.  As soon as that happens
  # the requirement for this flag will go away
  $demo = true

  filebucket { main: server => 'puppet' }

  File { owner => 0, group => 0, mode => 0644, backup => main }
  Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin" }

  # wget runs sometimes between firewall commands and fails, Package['wget'] ensures it runs after firewall
  # TODO find a better way to express that wget::fetch and wget::authfetch depend on firewall
  Firewall {
    before  => Class['maestro_nodes::firewall::post'],
    require => Class['maestro_nodes::firewall::pre'],
  }

  class { 'maestro_nodes::parent': }

}
