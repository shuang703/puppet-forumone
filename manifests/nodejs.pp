class forumone::nodejs ($modules = ["grunt-cli"]) {
  file { '/etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL':
    ensure => file,
    group  => 'root',
    mode   => '0644',
    owner  => 'root',
    source => "puppet:///modules/${module_name}/templates/nodejs/NODESOURCE-GPG-SIGNING-KEY-EL",
  }

  case $::osfamily {
    'RedHat': {
      if $::operatingsystemrelease =~ /^5\.(\d+)/ {
        include ::epel
        $dist_version  = '5'
        $name_string   = 'Enterprise Linux 5'
      }

      elsif $::operatingsystemrelease =~ /^6\.(\d+)/ {
        $dist_version = '6'
        $name_string  = 'Enterprise Linux 6'
      }

      elsif $::operatingsystemrelease =~ /^7\.(\d+)/ {
        $dist_version = '7'
        $name_string  = 'Enterprise Linux 7'
      }

      # Fedora
      elsif $::operatingsystemrelease =~ /(19)|(20)|(21)/ and $::operatingsystem == 'Fedora' {
        $dist_version  = $::operatingsystemrelease
        $name_string   = "Fedora Core ${::operatingsystemrelease}"
      }

      # newer Amazon Linux releases
      elsif ($::operatingsystem == 'Amazon') {
        $dist_version = '7'
        $name_string  = 'Enterprise Linux 7'
      }

      else {
        fail("Could not determine NodeSource repository URL for operatingsystem: ${::operatingsystem} operatingsystemrelease: ${::operatingsystemrelease}.")
      }

      $dist_type = $::operatingsystem ? {
        'Fedora' => 'fc',
        default  => 'el',
      }

      $url_suffix = '0.12'

      # nodesource repo
      $descr   = "Node.js Packages for ${name_string} - \$basearch"
      $baseurl = "https://rpm.nodesource.com/pub_${url_suffix}/${dist_type}/${dist_version}/\$basearch"

      # nodesource-source repo
      $source_descr   = "Node.js for ${name_string} - \$basearch - Source"
      $source_baseurl = "https://rpm.nodesource.com/pub_${url_suffix}/${dist_type}/${dist_version}/SRPMS"
    }
  }

  yumrepo { 'nodesource':
    descr          => $descr,
    baseurl        => $baseurl,
    enabled        => '1',
    failovermethod => 'priority',
    gpgkey         => 'file:///etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL',
    gpgcheck       => '1',
    require        => File['/etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL'],
  }

  package { 'npm' :
    ensure  => present,
    require => Yumrepo['nodesource']
  }
}
