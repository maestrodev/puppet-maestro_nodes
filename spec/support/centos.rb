# common utilities for CentOS servers

def centos_facts
  {
    :kernel          => 'Linux',
    :operatingsystem => 'CentOS',
    :osfamily        => 'RedHat',
    :postgres_default_version => '8.4', # CentOS 6.3
    :architecture    => 'x86_64'
  }
end
