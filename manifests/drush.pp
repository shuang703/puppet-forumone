class forumone::drush ($version = '7.x-5.9') {
  $filename = "drush-${version}.tar.gz"

  # Download drush
  exec { 'forumone::drush::download':
    command => "wget --directory-prefix=/opt http://ftp.drupal.org/files/projects/${filename}",
    path    => '/usr/bin',
    require => Package["java-1.7.0-openjdk"],
    creates => "/opt/${filename}",
    timeout => 4800,
  }

  # extract from the solr archive
  exec { 'forumone::drush::extract':
    command => "tar -zxvf /opt/${filename} -C /opt",
    path    => ["/bin"],
    require => [Exec["forumone::solr::download"]],
    creates => '/opt/drush/LICENSE.txt',
  }

  file { '/opt/drush':
    ensure  => directory,
    owner   => 'vagrant',
    require => Exec['forumone::drush::extract']
  }

  file { '/opt/drush/lib':
    ensure  => directory,
    owner   => 'vagrant',
    require => File['/opt/drush']
  }

  file { '/usr/local/bin/drush':
    ensure  => 'link',
    target  => '/opt/drush/drush',
    require => Exec['forumone::drush::extract']
  }
}