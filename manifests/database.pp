class forumone::database (
  $server        = true,
  $version       = '5.5',
  $manage_repo   = true,
  $configuration = {
    'mysqld/log_bin' => 'absent'
  }
) {

  class { 'percona':
    server          => $server,
    percona_version => $version,
    manage_repo     => $manage_repo,
    configuration   => $configuration
  }

  create_resources('forumone::database::database', hiera_hash('forumone::databases', {
  }
  ))
}