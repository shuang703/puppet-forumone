class forumone::php ($module = []) {
  if $::forumone::webserver::webserver == 'apache' {
    $service = "httpd"
  } elsif $::forumone::webserver::webserver == 'nginx' {
    $service = "nginx"
  }

  # PHP settings and modules
  $ini_settings = hiera_hash('php::ini', {
  }
  )

  $ini_settings[notify] = Service[$service, 'php-fpm']

  $ini = {
    '/etc/php.ini' => $ini_settings
  }

  create_resources('php::ini', $ini)

  $php_modules = concat(hiera_array('forumone::php::modules', []), $module)
  
  php::module { $php_modules: notify => Service[$service, 'php-fpm'] }

  package { 'php-fpm': ensure => present }

  service { 'php-fpm':
    ensure  => running,
    enable  => true,
    require => Package["php-fpm"]
  }

  file { '/etc/php-fpm.d/www.conf':
    ensure  => present,
    owner   => "root",
    group   => "root",
    content => template("forumone/fpm_pool.erb"),
    notify  => Service["php-fpm"],
    require => Package["php-fpm"]
  }

  create_resources('php::module::ini', hiera_hash('php::modules', {
  }
  ))
}