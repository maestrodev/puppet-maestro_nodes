Dir["./spec/support/**/*.rb"].each {|f| require f}
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.mock_framework = :rspec
  c.include MaestroNodes::CentOS
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))

  c.before(:each) do
    Puppet::Util::Log.level = :warning
    Puppet::Util::Log.newdestination(:console)
  end

end
