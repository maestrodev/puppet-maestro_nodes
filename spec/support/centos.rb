# common utilities for CentOS servers

def centos_facts
  let(:facts) { {
    :operatingsystem => 'CentOS',
    :osfamily        => 'RedHat',
    :postgres_default_version => '8.4' # CentOS 6.3
  } }
end
