class forumone::ffprobe () {
    $filename = "ffmpeg-release-64bit-static.tar.xz"
    $url = "http://johnvansickle.com/ffmpeg/releases/${filename}"
    $filepath = "/tmp/${filename}"
    $temporary = "/tmp/ffprobe"

    exec { "forumone::ffprobe::download":
        command => "wget --directory-prefix=/tmp ${url}",
        path => "/usr/bin",
        creates => "/tmp/${filename}",
        timeout => 4800,
    }

    exec { "forumone::ffprobe::extract":
        # Layout of the ffmpeg release tarball:
        #   ffmpeg-<version>-64bit-static/
        #   ffmpeg-<version>-64bit-static/ffserver
        #   ...
        #
        # Since we don't know the version number from the tarball, we list the files and assume the first
        # is the directory name.
        command => "tar -JOxf ${filepath} \$(tar -Jtf ${filepath} | sed -eq)ffprobe > ffprobe",
        path => "/bin",
        cwd => '/tmp',
        require => Exec['forumone::ffprobe::download'],
        creates => $temporary,
    }

    file { '/usr/local/bin/ffprobe':
        ensure => 'file',
        source => $temporary,
        mode => '0755',
        owner => 'root',
        group => 'root',
        require => Exec['forumone::ffprobe::extract'],
    }
}
