class forumone::composer(
  $home = '/home/vagrant/.composer'
) {
  # Download and install composer in one command 
  exec { 'forumone::composer::install':
    command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer",
    path    => '/usr/bin',
    creates => "/usr/bin/composer",
    timeout => 4800,
    require => Package["${::forumone::php::prefix}-fpm"]
  }
}
