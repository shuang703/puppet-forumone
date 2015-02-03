class forumone::mailcatcher (
  $smtp_ip        = '0.0.0.0',
  $smtp_port      = '1025',
  $http_ip        = '0.0.0.0',
  $http_port      = '1080',
  $path           = '/usr/bin',
  $version_i18n   = '0.6.11',
  $version_tilt   = '1.4.1',
  $version_mailcatcher = '0.5.12'
) {
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

  package { $packages: ensure => 'present' } ->
  package { 'i18n':
    ensure   => $version_i18n,
    provider => 'gem'
  } ->
  package { 'tilt':
    ensure   => $version_tilt,
    provider => 'gem'
  } ->
  package { 'mailcatcher':
    ensure   => $version_mailcatcher,
    provider => 'gem'
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
    require => Package["mailcatcher"]
  }

  service { 'mailcatcher':
    ensure  => running,
    hasstatus => false,
    enable => true,
    require => File["/etc/init.d/mailcatcher"]
  }
}
