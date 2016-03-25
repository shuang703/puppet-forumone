class forumone::nodejs ($modules = ["grunt-cli", "bower"], $version = 'v4.4.1') {
  class { '::nodejs':
    version	 => $version,
    make_install => false,
  }

  package { $modules:
    ensure   => present,
    provider => 'npm',
    require  => Class['::nodejs']
  }
}
