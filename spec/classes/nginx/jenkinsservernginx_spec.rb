require 'spec_helper'

describe 'maestro_nodes::nginx::jenkinsservernginx' do

  it { should contain_nginx__resource__location('jenkins_app') }
  it { should contain_nginx__resource__upstream('jenkins_app') }
  it { should contain_class('jenkins') }

end
