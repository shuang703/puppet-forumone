define forumone::solr::collection ($order = 10, $files = undef) {
  include forumone::solr

  file { "${::forumone::solr::path}/${name}":
    ensure  => 'directory',
    require => Exec["forumone::solr::extract"]
  }

  file { "${::forumone::solr::path}/${name}/conf":
    ensure  => 'directory',
    require => File["${::forumone::solr::path}/${name}"]
  }

  if $files == undef {
    if $::forumone::solr::major_version == "4" {
      $solr_files = [
        "${name}/elevate.xml",
        "${name}/protwords.txt",
        "${name}/mapping-ISOLatin1Accent.txt",
        "${name}/schema_extra_fields.xml",
        "${name}/schema_extra_types.xml",
        "${name}/schema.xml",
        "${name}/solrconfig_extra.xml",
        "${name}/solrconfig.xml",
        "${name}/solrcore.properties",
        "${name}/stopwords.txt",
        "${name}/synonyms.txt"]

        forumone::solr::file { "${name}/core.properties":
          template => "forumone/solr/conf/${::forumone::solr::conf}",
          directory => "${::forumone::solr::path}/${name}"
        }
    } elsif $::forumone::solr::major_version == "3" {
      concat::fragment { "solr_collection_${name}":
        target  => "${::forumone::solr::path}/solr.xml",
        content => "<core name='${name}' instanceDir='${name}' />",
        notify  => Service['solr']
      }
      $solr_files = [
        "${name}/elevate.xml",
        "${name}/protwords.txt",
        "${name}/mapping-ISOLatin1Accent.txt",
        "${name}/schema_extra_fields.xml",
        "${name}/schema_extra_types.xml",
        "${name}/schema.xml",
        "${name}/solrconfig_extra.xml",
        "${name}/solrconfig.xml",
        "${name}/solrcore.properties",
        "${name}/stopwords.txt",
        "${name}/synonyms.txt"]
    }
  } else {
    $solr_files = $files
  }

  forumone::solr::file { $solr_files:
    template  => "forumone/solr/conf/${::forumone::solr::conf}",
    directory => "${::forumone::solr::path}/${name}/conf"
  }
}
