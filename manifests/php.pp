class forumone::php (
  $module = [], 
  $prefix = 'php',
  $settings = {}
) {
  if $::forumone::webserver::webserver == 'apache' {
    $service = "httpd"
  } elsif $::forumone::webserver::webserver == 'nginx' {
    $service = "nginx"
  }
  
  # PHP settings and modules
  $params = hiera_hash('forumone::php::settings')
  $ini_settings = hiera_hash('php::ini', {
  }
  )
  
  $ini_settings[template] = 'forumone/php/php.ini-el6.erb'
  $ini_settings[notify] = Service[$service, 'php-fpm']

  $ini = {
    '/etc/php.ini' => $ini_settings
  }

  create_resources('php::ini', $ini)

  $php_modules = concat(hiera_array('forumone::php::modules', []), $module)

  php::module { $php_modules: 
    notify  => Service[$service, 'php-fpm'],
    require => Package["${::forumone::php::prefix}-fpm"]
  }

  package { "${::forumone::php::prefix}-fpm": ensure => present }

  service { "php-fpm":
    ensure  => running,
    enable  => true,
    require => Package["${::forumone::php::prefix}-fpm"]
  }

  file { '/etc/php-fpm.d/www.conf':
    ensure  => present,
    owner   => "root",
    group   => "root",
    content => template("forumone/fpm_pool.erb"),
    notify  => Service["php-fpm"],
    require => Package["${::forumone::php::prefix}-fpm"]
  }

  create_resources('php::module::ini', hiera_hash('php::modules', {
  }
  ))
}