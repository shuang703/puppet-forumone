class forumone::drush {
  package { "${::forumone::php::prefix}-pear": }

  pear { "Console_Table":
    package    => "Console_Table",
    creates    => "/usr/share/php/test/Console_Table",
    require    => Package["${::forumone::php::prefix}-pear"],
    php_prefix => $::forumone::php::prefix
  }

  pear { "drush":
    package    => "drush/drush",
    creates    => "/usr/bin/drush",
    channel    => "pear.drush.org",
    php_prefix => $::forumone::php::prefix
  }

  pear { "Archive_Tar":
    package    => "Archive_Tar",
    creates    => "/usr/share/doc/php5-common/PEAR/Archive_Tar",
    require    => Package["${::forumone::php::prefix}-pear"],
    php_prefix => $::forumone::php::prefix
  }
}