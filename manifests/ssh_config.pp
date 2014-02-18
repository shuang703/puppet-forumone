class forumone::ssh_config() {
  include concat::setup
  
  create_resources('forumone::ssh_config::host', hiera_hash('forumone::ssh_config', {
  }
  ))
}