require 'spec_helper'

describe 'maestro_nodes::agentrvm' do

  let(:hiera_data) {{
    'maestro_nodes::agent::repo' => {
      'url' => 'https://repo.maestrodev.com/archiva/repository/all',
      'username' => 'your_username',
      'password' => 'CHANGEME'
    }
  }}

  context "when using default params" do
    it { should_not contain_rvm__system_user('undef') }
    it { should contain_rvm__system_user('maestro_agent') }
  end

  context "when setting params" do
    let(:params) { {
      :agent_user => 'username'
    } }

    it { should_not contain_rvm__system_user('undef') }
    it { should contain_rvm__system_user('username') }
  end

  context "when wget was already defined" do
    let(:pre_condition) { "package { 'wget': ensure => present }" }

    it { should contain_package('wget') }
    it { should contain_rvm__system_user('maestro_agent') }
  end
end
