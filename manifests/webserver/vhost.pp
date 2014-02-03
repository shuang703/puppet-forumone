include forumone

define forumone::webserver::vhost (
  $path           = undef,
  $allow_override = ['All'],
  $source         = undef,
  $fastcgi_pass   = "unix:${::forumone::webserver::php_fpm_listen}",
  $platform       = 'drupal') {
  if $path {
    
    if $::forumone::webserver::webserver == 'apache' {
      apache::vhost { $name:
        port          => $::forumone::webserver::port,
        docroot       => $path,
        docroot_group => $::host_gid,
        docroot_owner => $::host_uid,
        directories   => [{
            path           => $path,
            allow_override => $allow_override
          }
          ]
      }
    } elsif $::forumone::webserver::webserver == 'nginx' {
      if empty($source) {
        nginx::file { "${name}.conf":
          content => template("forumone/webserver/nginx/vhost_${platform}.erb"),
          notify  => Service['nginx']
        }
      } else {
        nginx::file { 'localhost':
          source => $source,
          notify => Service['nginx']
        }
      }
    }
  }
}