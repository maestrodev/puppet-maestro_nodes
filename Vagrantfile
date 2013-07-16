Vagrant::Config.run do |config|
  # specify our basebox
  config.vm.box = "CentOS-6.4-x86_64-minimal"
  config.vm.box_url = "https://repo.maestrodev.com/archiva/repository/public-releases/com/maestrodev/vagrant/CentOS/6.4/CentOS-6.4-x86_64-minimal.box"

  # use UTC clock
  config.vm.customize ["modifyvm", :id, "--rtcuseutc", "on"]

  # use local puppetlib modules and this module as /etc/puppet
  config.vm.share_folder "dep-modules", "/etc/puppet/modules", "./spec/fixtures/modules", :create => true, :owner => "puppet", :group => "puppet"
  config.vm.share_folder "this-module", "/etc/puppet/modules/maestro_nodes", ".", :create => true, :owner => "puppet", :group => "puppet"

  # map the puppet graphs directory to local, so we can easily check them out in ./graphs
  config.vm.share_folder "puppet-graphs", "/var/lib/puppet/state/graphs", "graphs", :create => true, :owner => "puppet", :group => "puppet"

  # allow additional puppet options to be passed in (e.g. --graph, --debug, etc.)
  # note: splitting args is fragile and doesn't support spaces in args, but for now it works for what we need
  puppet_options = ["--modulepath", "/etc/puppet/modules", (ENV['PUPPET_OPTIONS']||"").split(/ /)];

  config.vm.provision :puppet do |puppet|
    puppet.options = puppet_options
    puppet.facter = { "maestrodev_username" => ENV['MAESTRODEV_USERNAME'], "maestrodev_password" => ENV['MAESTRODEV_PASSWORD'] }
    puppet.manifests_path = "tests"
    puppet.manifest_file  = "site.pp"
  end

  config.vm.define :firewall do |config|
    config.vm.host_name = "firewall.acme.com"
  end

  config.vm.define :metrics do |config|
    config.vm.host_name = "metrics.acme.com"
  end
end
