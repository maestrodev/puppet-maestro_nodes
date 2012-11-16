require 'spec_helper'

describe 'maestro_nodes::jenkinsserver' do
  it { should contain_package("jenkins") }
end
