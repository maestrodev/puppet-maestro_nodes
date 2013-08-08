require 'spec_helper'

describe 'maestro_nodes::agentrvm' do

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

end
