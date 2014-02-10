class forumone::webserver::nginx () {
  class { '::nginx':
    http_raw_lines   => $::forumone::webserver::nginx_conf,
    worker_processes => $::forumone::webserver::nginx_worker_processes,
    sendfile         => 'off'
  }
}
