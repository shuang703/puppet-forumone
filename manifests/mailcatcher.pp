class forumone::mailcatcher (
  $smtp_ip   = '0.0.0.0',
  $smtp_port = '1025',
  $http_ip   = '0.0.0.0',
  $http_port = '1080',
  $path      = '/usr/bin') {
  include forumone::ruby

  case $::osfamily {
    'Debian' : { $packages = ['ruby-dev', 'sqlite3', 'libsqlite3-dev', 'rubygems'] }
    'Redhat' : { $packages = ['ruby-devel', 'sqlite', 'sqlite-devel', 'rubygems'] }
    default  : { fail("${::osfamily} is not supported.") }
  }

  file { '/var/log/mailcatcher':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  $options = sort(join_keys_to_values({
    ' --smtp-ip'   => $smtp_ip,
    ' --smtp-port' => $smtp_port,
    ' --http-ip'   => $http_ip,
    ' --http-port' => $http_port,
  }
  , ' '))

  package { $packages: ensure => 'present' }

  rbenv::gem { 'tilt':
    user    => $::forumone::ruby::user,
    home    => $::forumone::ruby::home,
    root    => $::forumone::ruby::home,
    ruby    => $::forumone::ruby::version,
    require => Package[$packages]
  }

  rbenv::gem { 'mailcatcher':
    user    => $::forumone::ruby::user,
    home    => $::forumone::ruby::home,
    root    => $::forumone::ruby::home,
    ruby    => $::forumone::ruby::version,
    require => Rbenvgem["${::forumone::ruby::user}/${::forumone::ruby::version}/tilt/present"]
  }

  file { "/etc/default/mailcatcher":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("forumone/mailcatcher/etc_default.erb"),
  }

  file { "/etc/init.d/mailcatcher":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "755",
    content => template("forumone/mailcatcher/mailcatcher.erb"),
    require => Rbenvgem["${::forumone::ruby::user}/${::forumone::ruby::version}/mailcatcher/present"]
  }

  service { 'mailcatcher':
    ensure    => running,
    hasstatus => false,
    enable    => true,
    require   => File["/etc/init.d/mailcatcher"]
  }
}