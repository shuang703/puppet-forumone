class forumone ($ports = [80, 443, 8080, 8081, 18983, 8983, 3306, 13306, 1080],) {
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

  create_resources('forumone::solr::collection', hiera_hash('forumone::solr::collections', {
  }
  ))
}
