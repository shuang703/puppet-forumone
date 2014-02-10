class forumone::webserver::apache {
  class { '::apache':
    default_vhost => false,
    mpm_module    => false,
    sendfile      => 'Off'
  }

  class { 'apache::mod::prefork':
    startservers        => $::forumone::webserver::apache_startservers,
    minspareservers     => $::forumone::webserver::apache_minspareservers,
    maxspareservers     => $::forumone::webserver::apache_maxspareservers,
    serverlimit         => $::forumone::webserver::apache_serverlimit,
    maxclients          => $::forumone::webserver::apache_maxclients,
    maxrequestsperchild => $::forumone::webserver::apache_maxrequestsperchild,
  }

  class { 'php::mod_php5':
  }

}
