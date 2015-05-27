class forumone::webserver::nginx () {
  exec {'create_self_signed_sslcert':
    command => "openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/localhost.key  -x509 -days 365 -out ${certdir}/localhost.crt -subj '/CN=${::fqdn}'",
    cwd     => $certdir,
    creates => [ "/etc/ssl/private/localhost.key", "${certdir}/localhost.crt", ],
    path    => ["/usr/bin", "/usr/sbin"]
  }

  class { '::nginx':
    http_raw_lines   => $::forumone::webserver::nginx_conf,
    worker_processes => $::forumone::webserver::nginx_worker_processes,
    sendfile         => 'off'
  }

# Remove apache if it's installed  
  include '::apache::params'

  class { '::apache::service':
    service_enable  => false,
    service_ensure  => false
  }
}
