class puppet_common::init_hiera (
  $template_name         = 'hiera.yaml',
  $gpg_name              = undef,
  $hiera_data_dir        = "${::settings::confdir}/hiera_data",
  $hiera_secret_data_dir = "${::settings::confdir}/hiera_data/secret",) {
  Package {
    allow_virtual => false, }

  package { ['ruby-devel', 'gcc']: }

  package { 'deep_merge':
    ensure   => 'installed',
    provider => 'gem',
  }

  if ($gpg_name and module_component_exists($caller_module_name, "files/${gpg_name}.gpg")) {
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
