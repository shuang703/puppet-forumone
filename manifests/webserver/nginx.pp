class forumone::webserver::nginx () {
  class { '::nginx':
    http_raw_lines   => $::forumone::webserver::nginx_conf,
    worker_processes => $::forumone::webserver::nginx_worker_processes,
    sendfile         => 'off'
  }

# Remove apache if it's installed  
  include '::apache::params'

  class { '::apache::package':
    ensure   => 'purged'
  }

  class { '::apache::service':
    service_enable  => false,
    service_ensure  => false
  }
}
