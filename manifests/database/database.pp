define forumone::database::database ($username = undef, $password = undef) {
  include forumone::database

  if $password {
    $db_password = $password
  }
  else {
    $db_password = $username
  }

  percona::database { $name:
    ensure  => present,
    require => Class['percona']
  }

  percona::rights { "${username}@localhost/${name}":
    priv     => 'all',
    user     => $username,
    database => $name,
    password => $db_password,
    host     => 'localhost'
  }

  percona::rights { "${username}@%/${name}":
    priv     => 'all',
    user     => $username,
    database => $name,
    password => $db_password,
    host     => '%'
  }
}
