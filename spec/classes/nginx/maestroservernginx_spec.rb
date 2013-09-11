require 'spec_helper'

describe 'maestro_nodes::nginx::maestroservernginx' do

  let(:facts) { centos_facts.merge(:fqdn => 'puppet.acme.com', :custom_location => 'maestroservernginx') }

  let(:hiera_data) {{
    'maestro::maestro::repo' => {
      'id' => 'maestro-mirror',
      'username' => 'u',
      'password' => 'p',
      'url' => 'https://repo.maestrodev.com/archiva/repository/all'
    }
  }}

  it { should contain_nginx__resource__vhost('puppet.acme.com').with_proxy('http://maestro_app') }
  it { should contain_nginx__resource__upstream('maestro_app') }
  it { should contain_class('maestro::maestro') }

end
