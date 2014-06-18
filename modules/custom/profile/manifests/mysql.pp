class profile::mysql {
  # install mysql client
  include mysql::client

  # load the mysql options from hiera and pass them to mysql::server
  $override_options = hiera_hash('profile::mysql::override_options', undef)

  if $override_options {
    class { 'mysql::server':
      override_options => $override_options,
      require          => [Package['mysql_client']]
    }
  } else {
    # we don't use default options, so error if nothing is found
    fail('No hash found in hiera to override default mysql settings in class profile::mysql::base.')
  }

  # make sure percona toolkit and xtrabackup are present
  package { 'percona-toolkit': ensure => latest, }

  package { 'percona-xtrabackup':
    ensure  => latest,
  }

  yumrepo { 'percona':
    descr    => 'CentOS $releasever - Percona',
    enabled  => 1,
    baseurl  => 'http://repo.percona.com/centos/$releasever/os/$basearch/',
    gpgkey   => 'http://www.percona.com/downloads/RPM-GPG-KEY-percona',
    gpgcheck => 1,
    before   => [ Package['mysql-server'], Package['mysql_client'] ],
  }
}
