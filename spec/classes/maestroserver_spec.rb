require 'spec_helper'

describe 'maestro_nodes::maestroserver' do

  let(:params) {{
    :repo => {
        'id' => 'maestro-mirror',
        'username' => 'u',
        'password' => 'p',
        'url' => 'https://repo.maestrodev.com/archiva/repository/all'
    },
    :disabled => false
  }}

  it { should include_class('maestro::maestro') }
  it { should include_class('maestro_nodes::metrics_repo') }
  it { should include_class('maestro_nodes::database') }
  it { should include_class('activemq') }
  it { should include_class('activemq::stomp') }
  it { should include_class('maestro::plugins') }

  context 'when disabling maestro' do
    let(:params) { super().merge({:disabled => true}) }
    it { should contain_class('maestro::maestro').with( { :enabled => false }) }
  end

end
