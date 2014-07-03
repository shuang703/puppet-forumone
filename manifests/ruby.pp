class forumone::ruby (
  $version      = "1.9.3-p484",
  $user         = "vagrant",
  $group        = "vagrant",
  $home         = "/home/vagrant",
  $gemfile_path = undef) {
  package { 'gcc': ensure => present }

  if $version {
    rbenv::plugin::rbenvvars { $user:
      user => $user,
      home => $home,
      root => $home
    }

    rbenv::install { $user:
      user => $user,
      home => $home,
      root => $home
    }

    rbenv::compile { $version:
      user    => $user,
      home    => $home,
      root    => $home,
      require => Package['gcc']
    }
  }

  if $gemfile_path {
    file { "/home/${user}/Gemfile":
      ensure  => present,
      path    => "/home/${user}/Gemfile",
      owner   => $user,
      group   => $group,
      content => file($gemfile_path),
      backup  => false,
    }

    exec { "${user} bundle":
      command   => "bundle",
      cwd       => "/vagrant",
      user      => $user,
      group     => $group,
      path      => "/home/${user}/bin:/bin:/usr/bin",
      creates   => "${$gemfile_path}.lock",
      subscribe => File["/home/${user}/Gemfile"],
      require   => Rbenvgem["${user}/${version}/bundler/present"]
    }
  }
}
