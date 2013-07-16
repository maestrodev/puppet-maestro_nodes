import '/etc/puppet/modules/maestro_nodes/manifests/nodes/*.pp'

# test that wget requests happen after firewall has been setup
node 'firewall.acme.com' inherits 'parent' {
  class { 'maestro_nodes::maestrofirewall': }
  class { 'maestro_nodes::firewall::puppetmaster': }

  class { 'ant': }
  class { 'ant::ivy': }
  class { 'ant::tasks::maven': }
  class { 'ant::tasks::sonar': }
}

node 'metrics.acme.com' inherits 'parent' {
  include 'maestro_nodes::metrics_repo'
}
