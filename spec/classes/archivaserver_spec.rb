require 'spec_helper'

describe 'maestro_nodes::archivaserver' do

  let(:facts) { centos_facts }

  let(:params) { {
    :db_password => 'mypassword'
  } }

  it { should contain_postgresql__db("archiva") }
end
