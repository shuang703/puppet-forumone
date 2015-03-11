class forumone::mailcatcher (
  $smtp_ip        = '0.0.0.0',
  $smtp_port      = '1025',
  $http_ip        = '0.0.0.0',
  $http_port      = '1080',
  $path           = '/usr/bin'
) {
  case $::osfamily {
    'Debian' : { $packages = ['ruby-dev', 'sqlite3', 'libsqlite3-dev'] }
    'Redhat' : { $packages = ['ruby-devel', 'sqlite', 'sqlite-devel'] }
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

  package { $packages: 
    ensure  => present
  }

  class { '::ruby':
    gems_version  => 'latest',
    require       => Package[$packages]
  } ->
  package { 'bundler':
    provider => 'gem'
  }

  file { "/opt/puppet/mailcatcher": 
    ensure => 'directory'
  }

  file { "/opt/puppet/mailcatcher/Gemfile":
    source  => "/etc/puppet/modules/forumone/templates/mailcatcher/Gemfile",
    require => File['/opt/puppet/mailcatcher']
  }

  ruby::bundle { 'mailcatcher':
    cwd         => '/opt/puppet/mailcatcher',
    subscribe   => File['/opt/puppet/mailcatcher/Gemfile'],
    require     => Package['bundler'],
    user        => 'root',
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    refreshonly => true
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
    require => Ruby::Bundle['mailcatcher']
  }

  service { 'mailcatcher':
    ensure  => running,
    hasstatus => false,
    enable => true,
    require => File["/etc/init.d/mailcatcher"]
  }
}
