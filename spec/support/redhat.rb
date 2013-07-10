# common utilities for RedHat servers

shared_context :redhat do

  let(:redhat_facts) {{
    :kernel          => 'Linux',
    :operatingsystem => 'RedHat',
    :lsbmajdistrelease => '6',
    :osfamily        => 'RedHat',
    :postgres_default_version => '8.4',
    :architecture    => 'x86_64'
  }}

  let(:facts) { redhat_facts }
end
