require 'spec_helper'

describe 'maestro_nodes::maestro' do


  DEFAULT_MAESTRO_PARAMS = {
    :repo => {
        'id' => 'maestro-mirror',
        'username' => 'u',
        'password' => 'p',
        'url' => 'https://repo.maestrodev.com/archiva/repository/all'
    },
    :disabled => false
  }

  let(:facts) { centos_facts }
  let(:params) { DEFAULT_MAESTRO_PARAMS }

  it { should include_class('maestro::maestro') }
  it { should include_class('maestro_nodes::metrics_repo') }
  it { should include_class('maestro_nodes::database') }
  it { should include_class('maestro_nodes::nginxproxy') }
  it { should include_class('activemq') }
  it { should include_class('activemq::stomp') }
  it { should include_class('maestro::plugins') }

  context 'when disabling maestro' do
    params = {
        :repo => {
            'id' => 'maestro-mirror',
            'username' => 'u',
            'password' => 'p',
            'url' => 'https://repo.maestrodev.com/archiva/repository/all'
        },
        :disabled => true
    }
    let(:params) { params }
    it { should contain_class('maestro::maestro').with( { :enabled => false }) }

  end

end
