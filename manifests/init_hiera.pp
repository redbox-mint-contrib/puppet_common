class puppet_common::init_hiera {
  Package {
    allow_virtual => false, }

  package { ['ruby-devel', 'gcc']: }

  package { 'deep_merge':
    ensure   => 'installed',
    provider => 'gem',
  }

  file { "init_${::settings::hiera_config}":
    path    => $::settings::hiera_config,
    ensure  => file,
    content => template("puppet_common/${::settings::hiera_config}.erb"),
  }

}
