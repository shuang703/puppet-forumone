define forumone::ssh_config::host (
  $unix_user,
  $remote_user,
  $hostname,
  $port            = 22,
  $proxy_command   = undef,
  $connect_timeout = undef,
  $forward_agent   = undef) {
  $ssh_config_dir_prefix = "/home/${unix_user}/.ssh"

  $ssh_config_file = "${ssh_config_dir_prefix}/config"

  ensure_resource('concat', $ssh_config_file, {
    owner => $unix_user
  }
  )

  concat::fragment { "ssh_config_${unix_user}_${title}":
    target  => $ssh_config_file,
    content => template('forumone/ssh_config.erb')
  }
}