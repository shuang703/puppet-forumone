class forumone::ruby ($version = "1.9.3-p484", $user = "vagrant", $group = "vagrant", $gemfile_path = undef) {
  rbenv::plugin::rbenvvars { $user:
    user  => $user,
    group => $group,
    home  => "/home/${user}",
    root  => "/home/${user}/.rbenv"
  }

  rbenv::install { $user:
    user  => $user,
    group => $group,
    home  => "/home/${user}",
    root  => "/home/${user}/.rbenv"
  }

  rbenv::compile { $version:
    user  => $user,
    group => $group,
    home  => "/home/${user}",
    root  => "/home/${user}/.rbenv"
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
	    path      => "/home/${user}/bin:/home/${user}/.rbenv/shims:/bin:/usr/bin",
	    creates   => "${$gemfile_path}.lock",
	    subscribe => File["/home/${user}/Gemfile"],
	    require   => Rbenvgem["${user}/${version}/bundler/present"]
	  }
  }
}
