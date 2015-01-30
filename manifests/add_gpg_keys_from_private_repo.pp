define puppet_common::add_yum_repo (
  $gpg_key      = hiera_hash(gpg_source, {
    name   => 'gpg_coesra_kepler_dev.private.key',
    source => 'git@bitbucket.org:coesra/sys-admin.git',
    path   => '/tmp/sys-admin',
  }
  ),
  $gpg_home_dir = "${::settings::confdir}/gpg",) {
  ensure(file, $gpg_home_dir, {
    ensure  => directory,
    owner   => $puppet_user,
    recurse => true,
  }
  )

  file { "${::settings::confdir}/gpg":
    ensure  => directory,
    owner   => $puppet_user,
    recurse => true,
  }

  vcsrepo { $gpg_source[path]:
    ensure   => present,
    provider => git,
    source   => $gpg_source[source],
  } -> exec { "gpg --homedir=${gpg_home_dir} --allow-secret-key-import --import ${gpg_key[path]}/gpg-keys/${gpg_key
    [name]}": } -> file { $gpg_key[path]:
    ensure => absent,
    force  => true,
  }
}
