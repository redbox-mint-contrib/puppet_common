define puppet_common::add_gpg_from_repo (
  $key_name     = hiera_hash('gpg_key::name', $title),
  $source       = hiera_hash('gpg_key::source', undef),
  $path         = hiera_hash('gpg_key::path', undef),
  $gpg_home_dir = hiera_hash('gpg::home_dir', "${::settings::confdir}/gpg"),) {
  ensure(file, $gpg_home_dir, {
    ensure  => directory,
    owner   => $puppet_user,
    recurse => true,
  }
  )

  vcsrepo { $gpg_source[path]:
    ensure   => present,
    provider => git,
    source   => $gpg_source[source],
  } ->
  exec { "add gpg ${gpg_key[name]}":
    command => "gpg --homedir=${gpg_home_dir} --allow-secret-key-import --import ${gpg_key[path]}/gpg-keys/${gpg_key
      [name]}",
    require => File[$gpg_home_dir],
    cwd     => $gpg_home_dir,
  }

  ensure(file, "remove gpg key repo:${gpg_key[path]}", {
    path    => $gpg_key[path],
    ensure  => absent,
    force   => true,
    require => Exec["add gpg ${gpg_key[name]}"],
  }
  )
}
