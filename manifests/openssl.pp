class forumone::openssl () {
  openssl::certificate::x509 { $server:
    country      => 'US',
    organization => 'Forum One',
    commonname   => $fqdn,
    base_dir     => '/etc/ssl',
  }
}