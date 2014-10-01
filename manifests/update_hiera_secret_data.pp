define puppet_common::update_hiera_secret_data (
  $gpg_name              = $title,
  $hiera_data_dir        = "${::settings::confdir}/hiera_data",
  $hiera_secret_data_dir = "${::settings::confdir}/hiera_data/secret") {
  if (module_component_exists($caller_module_name, "files/${gpg_name}.gpg")) {
    ensure_resource('package', 'hiera-gpg', {
      ensure   => 'installed',
      provider => 'gem',
    }
    )

    ensure_resource('file', "secret_${::settings::hiera_config}", {
      ensure  => file,
      path    => $::settings::hiera_config,
      content => template("puppet_common/secret/${::settings::hiera_config}.erb"),
    }
    )

    ensure_resource('puppet_common::add_directory', $hiera_secret_data_dir)

    file { "${hiera_secret_data_dir}/${gpg_name}.gpg":
      ensure    => file,
      source    => "puppet:///modules/${caller_module_name}/${gpg_name}.gpg",
      subscribe => Puppet_common::Add_directory[$hiera_secret_data_dir],
    }
  } else {
    notify { 'No gpg configuration available for ${gpg_name} in ${caller_module_name} - existing hiera config remains.'
    : }
  }
}
