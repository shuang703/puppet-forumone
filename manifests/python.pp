class forumone::python(
  $interpreter = 'system'
) {
  include "pythonel::interpreter::${interpreter}"

  pythonel::virtualenv { '/vagrant/env':
    interpreter => $interpreter,
    requirements_file => '/vagrant/requirements.txt',
    systempkgs => true,
    owner => $::host_uid,
    group => $::host_gid
  }
}
