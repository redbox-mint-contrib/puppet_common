class puppet_common::init_hiera {
  include 'puppet_common::variables::puppet'

  Package {
    allow_virtual => false, }

  package { ['ruby-devel', 'gcc']: }

  package { ['deep_merge', 'hiera-gpg']:
    ensure   => 'installed',
    provider => 'gem',
  }

  file { "$puppet_common::variables::puppet::conf_dir/${hiera_config_name}":
    ensure  => file,
    content => template("${caller_module_name}/${hiera_config_name}.erb"),
  }

}
