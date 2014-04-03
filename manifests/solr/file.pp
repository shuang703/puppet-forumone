define forumone::solr::file ($template = undef, $config_directory = undef, $directory = undef, $collection = undef) {
  $name_array = split($name, '[/]')
  $file_array = split($name_array[1], '[.]')
  $file_array_pieces = delete_at($file_array, (size($file_array) - 1))
  $file_name = join($file_array_pieces, ".")
  $file_destination = "${directory}/${name_array[1]}"

  if !$config_directory {
    if $template {
      $resolved_template = $template
    }
    else {
      $resolved_template = 'forumone/solr'
    }

    $template_array = split($resolved_template, '[/]')
    $module = $template_array[0]
    $path = join(delete_at($template_array, 0), '/')

    $file_template = "/etc/puppet/modules/${module}/templates/${path}/${file_name}.erb"
  }
  else {
    $file_template = "${config_directory}/${$file_name}.erb"  
  }

  file { $file_destination:
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "755",
    content => inline_template(file($file_template)),
    require => [ File[$directory], Exec["forumone::solr::extract"] ],
    notify => Service["solr"]
  }
}
