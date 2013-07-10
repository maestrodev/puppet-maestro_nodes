require 'spec_helper'

describe 'maestro_nodes::nginx::sonar' do

  default_params = {
      :sonar_port => '8083',
      :hostname => 'maestro.acme.com',
      :ssl => false,
  }

  let(:params) { default_params }

  context "with default parameters" do
    it { should contain_nginx__resource__location("sonar_app").with(
                    :ssl => false,
                    :ssl_only => false,
                    :vhost => 'maestro.acme.com',
                    :location => '/sonar',
                    :proxy => 'http://sonar_app',
                ) }

    it { should contain_nginx__resource__upstream("sonar_app").with_members(["localhost:8083"]) }
  end

  context "with SSL" do
    let(:params) { default_params.merge ({
        :ssl => true,
    }) }
    it { should contain_nginx__resource__location("sonar_app").with(
                    :ssl => true,
                    :ssl_only => true,
                    :vhost => 'maestro.acme.com',
                    :location => '/sonar',
                    :proxy => 'http://sonar_app',
                ) }

    it { should contain_nginx__resource__upstream("sonar_app").with_members(["localhost:8083"]) }
  end

end
