class puppet_common::init_hiera ($template_name = 'hiera.yaml', $has_secrets = true) {
  require 'puppet_common::variables::puppet'

  Package {
    allow_virtual => false, }

  package { ['ruby-devel', 'gcc']: }

  package { 'deep_merge':
    ensure   => 'installed',
    provider => 'gem',
  }

  if (has_secrets) {
    file { "secret_${::settings::hiera_config}":
      ensure  => file,
      path    => $::settings::hiera_config,
      content => template("puppet_common/secret/${template_name}.erb"),
    }
  } else {
    file { "init_${::settings::hiera_config}":
      ensure  => file,
      path    => $::settings::hiera_config,
      content => template("puppet_common/${template_name}.erb"),
    }
  }
}
