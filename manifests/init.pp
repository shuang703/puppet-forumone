class forumone (
  $ports                 = $forumone::params::ports,
  $percona_install       = $forumone::params::percona_install,
  $percona_manage_repo   = $forumone::params::percona_manage_repo,
  $percona_version       = $forumone::params::percona_version
) inherits forumone::params {
  case $::operatingsystem {
    /(?i:redhat|centos)/ : {
      class { 'forumone::os::fedora::project': }
    }
  }

  file { "/home/vagrant/.bashrc":
    ensure  => present,
    owner   => "vagrant",
    group   => "vagrant",
    mode    => "644",
    content => template("forumone/bashrc.erb"),
  }

  file { "/home/vagrant/.ssh/config":
    ensure  => present,
    content => template("forumone/ssh_config.erb"),
    owner   => "vagrant",
    mode    => 600
  }

  if $percona_install == true {
    file { '/etc/mysql': ensure => 'directory', }

    file { '/etc/mysql/conf.d': ensure => 'directory', }

    class { 'percona':
      server             => true,
      percona_version    => $percona_version,
      manage_repo        => $percona_manage_repo,
      config_include_dir => '/etc/mysql/conf.d',
      configuration      => {
        'mysqld/log_bin' => 'absent'
      }
    }
    
    create_resources('forumone::database', hiera_hash('forumone::databases', {}))
  }
}