class forumone::params (
  $ports        = [80, 443, 8080, 8081, 18983, 8983, 3306, 13306, 1080],
  # Percona configuration
  $percona_install            = true,
  $percona_manage_repo        = true,
  $percona_version            = "5.5",
  $webserver    = "nginx",
  $webserver_port             = "8080",
  # Apache configuration
  $apache_startservers        = 8,
  $apache_minspareservers     = 5,
  $apache_maxspareservers     = 16,
  $apache_serverlimit         = 16,
  $apache_maxclients          = 16,
  $apache_maxrequestsperchild = 200,
  # nginx conf
  $nginx_conf   = ["client_max_body_size 200m", "client_body_buffer_size 2m", "set_real_ip_from 127.0.0.1", "real_ip_header X-Forwarded-For"],
  $nginx_worker_processes     = 1,
  # PHP configuration
  $php_fpm_listen = "/var/run/php-fpm.sock"
  ) {
}
