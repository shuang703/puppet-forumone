class forumone::nodejs ($modules = ["grunt-cli"], $version = 'v0.12.9') {
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
