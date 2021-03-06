define puppet_common::add_gpg_from_repo (
  $key_name     = $title,
  $source       = undef,
  $path         = undef,
  $gpg_home_dir = "${::settings::confdir}/gpg") {
  file { $gpg_home_dir:
    ensure  => directory,
    recurse => true,
  }

  vcsrepo { $path:
    ensure   => present,
    provider => git,
    source   => $source,
  } ->
  exec { "add gpg ${key_name}":
    command => "/usr/bin/gpg --homedir=${gpg_home_dir} --allow-secret-key-import --import ${path}/gpg-keys/${key_name}",
    require => File[$gpg_home_dir],
    cwd     => $gpg_home_dir,
  }

  ensure_resource(file, "remove gpg key repo:${path}", {
    path    => $path,
    ensure  => absent,
    force   => true,
    require => Exec["add gpg ${key_name}"],
  }
  )
}
