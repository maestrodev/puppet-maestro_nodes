require 'spec_helper'

describe 'maestro_nodes::archivaserver' do

  let(:pre_condition) { "class {'maestro::params': db_password => 'mypassword'}" }

  it { should contain_postgresql__db("archiva").with({
    :user => 'maestro',
    :password => 'mypassword'
  }) }
end
