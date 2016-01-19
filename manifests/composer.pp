class forumone::composer(
  $home = '/home/vagrant/.composer',
  $user = 'vagrant'
) {
  # Download and install composer in one command 
  exec { 'forumone::composer::install':
    command     => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer",
    path        => '/usr/bin',
    creates     => "/usr/bin/composer",
    timeout     => 4800,
    require     => Class["forumone::php"],
    environment => ["COMPOSER_HOME=${home}"],
  }

  file { $home:
    ensure => 'directory',
    owner  => $user,
    group  => $user
  }
}
