class forumone::python(
  $interpreter = 'system',
  $pip_package = 'python-pip'
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
