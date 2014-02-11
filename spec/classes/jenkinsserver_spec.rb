require 'spec_helper'

describe 'maestro_nodes::jenkinsserver' do
  let(:settings_xml) { "/var/lib/jenkins/.m2/settings.xml" }

  context "when using default params", :compile do
    it { should contain_package("jenkins").with_ensure("present") }
    it { should contain_wget__fetch("git.hpi").with_source(/1\.4\.0/) }
  end

  context "when changing admin in maestro", :compile do
    let(:pre_condition) { %Q[
      class {'maestro::params':
        admin_username => 'myuser',
        admin_password => 'mypassword',
      }
    ]}
    it { should contain_file(settings_xml).with_content(%r[<username>myuser</username>]) }
    it { should contain_file(settings_xml).without_content(%r[<username>admin</username>]) }
    it { should contain_file(settings_xml).with_content(%r[<password>mypassword</password>]) }
    it { should contain_file(settings_xml).without_content(%r[<password>admin1</password>]) }
  end
end
