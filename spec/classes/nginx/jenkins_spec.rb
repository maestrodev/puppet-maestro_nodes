require 'spec_helper'

describe 'maestro_nodes::nginx::jenkins' do

  default_params = {
      :jenkins_port => '8181',
      :hostname => 'maestro.acme.com',
      :ssl => false,
  }

  let(:facts) { centos_facts }

  let(:params) { default_params }

  context "with default parameters" do
    it { should contain_nginx__resource__location("jenkins_app").with(
                    :ssl => false,
                    :ssl_only => false,
                    :vhost => 'maestro.acme.com',
                    :location => '/jenkins',
                    :proxy => 'http://jenkins_app',
                ) }

    it { should contain_nginx__resource__upstream("jenkins_app").with_members(["localhost:8181"]) }
  end

  context "with SSL" do
    let(:params) { default_params.merge ({
        :ssl => true,
    }) }
    it { should contain_nginx__resource__location("jenkins_app").with(
                    :ssl => true,
                    :ssl_only => true,
                    :vhost => 'maestro.acme.com',
                    :location => '/jenkins',
                    :proxy => 'http://jenkins_app',
                ) }

    it { should contain_nginx__resource__upstream("jenkins_app").with_members(["localhost:8181"]) }
  end

end
