require 'spec_helper'

describe 'maestro_nodes::nginx::archiva' do

  default_params = {
      :archiva_port => '8082',
      :hostname => 'maestro.acme.com',
      :ssl => false,
  }

  let(:facts) { centos_facts }

  let(:params) { default_params }

  context "with default parameters" do
    it { should contain_nginx__resource__location("archiva_app").with(
                    :ssl => false,
                    :ssl_only => false,
                    :vhost => 'maestro.acme.com',
                    :location => '/archiva',
                    :proxy => 'http://archiva_app',
                ) }

    it { should contain_nginx__resource__upstream("archiva_app").with_members(["localhost:8082"]) }
  end

  context "with SSL" do
    let(:params) { default_params.merge ({
        :ssl => true,
    }) }
    it { should contain_nginx__resource__location("archiva_app").with(
                    :ssl => true,
                    :ssl_only => true,
                    :vhost => 'maestro.acme.com',
                    :location => '/archiva',
                    :proxy => 'http://archiva_app',
                ) }

    it { should contain_nginx__resource__upstream("archiva_app").with_members(["localhost:8082"]) }
  end

end
