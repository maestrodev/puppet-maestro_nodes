require 'spec_helper'

describe 'maestro_nodes::agent' do

  DEFAULT_AGENT_PARAMS = {
    :repo => {
        'id' => 'maestro-mirror',
        'username' => 'u',
        'password' => 'p',
        'url' => 'https://repo.maestrodev.com/archiva/repository/all'
    },
    :version => '1.0'
  }

  # ================================================ Linux ================================================

  context "when running on CentOS" do
    let(:facts) { {:operatingsystem => 'CentOS', :kernel => 'Linux', :osfamily => 'RedHat'} }
    let(:params) { DEFAULT_AGENT_PARAMS }

    it { should_not contain_package("libxml2-devel") }
  end

  # ================================================ OS X ================================================

  context "when running on OS X" do
    let(:facts) { {:operatingsystem => 'Darwin', :kernel => 'Darwin', :osfamily => 'Darwin'} }
    let(:params) { DEFAULT_AGENT_PARAMS }

    it { should_not contain_package("libxml2-devel") }
  end

  # ================================================ Windows ================================================

  context "when running on Windows" do
    let(:facts) { {:operatingsystem => 'windows', :kernel => 'windows', :osfamily => 'windows'} }
    let(:params) { DEFAULT_AGENT_PARAMS }

    it { should_not contain_package("libxml2-devel") }
  end

end
