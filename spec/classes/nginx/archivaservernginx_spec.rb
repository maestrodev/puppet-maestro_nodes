require 'spec_helper'

describe 'maestro_nodes::nginx::archivaservernginx' do
  let(:facts) { centos_facts.merge({:postgres_default_version => '6.4'}) }

  it { should contain_nginx__resource__location('archiva_app') }
  it { should contain_nginx__resource__upstream('archiva_app') }
  it { should contain_class('archiva') }

end
