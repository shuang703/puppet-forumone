define forumone::database::database ($username = undef, $password = undef) {
  include forumone::database

  if !$password {
    $password = $username
  }

  percona::database { $name:
    ensure  => present,
    require => Class['percona']
  }

  percona::rights { "${username}@localhost/${name}":
    priv     => 'all',
    user     => $username,
    database => $name,
    password => $password,
    host     => 'localhost'
  }

  percona::rights { "${username}@%/${name}":
    priv     => 'all',
    user     => $username,
    database => $name,
    password => $password,
    host     => '%'
  }
}
