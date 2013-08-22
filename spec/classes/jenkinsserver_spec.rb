require 'spec_helper'

describe 'maestro_nodes::jenkinsserver' do
  it { should contain_package("jenkins").with_ensure("present") }
  it { should contain_wget__fetch("git.hpi").with_source(/1\.4\.0/) }
end
