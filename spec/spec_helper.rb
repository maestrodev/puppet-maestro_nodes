Dir["./spec/support/**/*.rb"].each {|f| require f}
require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera-puppet-helper/rspec'
require 'hiera'
require 'puppet/indirector/hiera'

# config hiera to work with let(:hiera_data)
def hiera_stub
  config = Hiera::Config.load(hiera_config)
  config[:logger] = 'puppet'
  Hiera.new(:config => config)
end

RSpec.configure do |c|
  c.mock_framework = :rspec
  c.include MaestroNodes::CentOS

  c.before(:each) do
    Puppet::Indirector::Hiera.stub(:hiera => hiera_stub)
    Puppet::Util::Log.level = :warning
    Puppet::Util::Log.newdestination(:console)
  end

end
