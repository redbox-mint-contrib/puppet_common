define puppet_common::add_gpg_from_repo (
  $key_name     = hiera_hash('gpg_key::name', $title),
  $source       = hiera_hash('gpg_key::source', undef),
  $path         = hiera_hash('gpg_key::path', undef),
  $gpg_home_dir = hiera_hash('gpg::home_dir', "${::settings::confdir}/gpg"),) {
  ensure_resource(file, $gpg_home_dir, {
    ensure  => directory,
    owner   => 'puppet',
    recurse => true,
  }
  )

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
