require 'spec_helper'

describe 'maestro_nodes::agent' do

  USER_HOME="/var/local/maestro-agent"

  DEFAULT_AGENT_PARAMS = {
    :repo => {
        'id' => 'maestro-mirror',
        'username' => 'u',
        'password' => 'p',
        'url' => 'https://repo.maestrodev.com/archiva/repository/all'
    },
    :version => '1.0'
  }

  let(:facts) { centos_facts }
  let(:params) { DEFAULT_AGENT_PARAMS }

  it { should contain_user('maestro_agent') }

  it { should contain_package('git').with_ensure('present') }
  it { should contain_package('subversion').with_ensure('installed') }

  it { should contain_file("#{USER_HOME}/.m2/settings.xml").with_owner('maestro_agent') }
  it { should_not contain_file("#{USER_HOME}/.ssh/config") }

  it { 
    should contain_file("server.key").with_path("#{USER_HOME}/.maestro/server.key") 
    should contain_file("#{USER_HOME}").with_ensure(:directory)
  }

  it { should_not contain_file("/home/agent").with_ensure(:directory) }
  it { should_not contain_file("/home/agent/.maestro") }


  # ================================================ Linux ================================================

  context "when running on CentOS" do
    let(:facts) { centos_facts }
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
