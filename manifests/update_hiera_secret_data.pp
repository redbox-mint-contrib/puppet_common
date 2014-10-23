define puppet_common::update_hiera_secret_data ($gpg_name = $title,) {
  require 'puppet_common::variables::puppet'

  if (module_component_exists($caller_module_name, "files/${gpg_name}.gpg")) {
    ensure_resource('package', 'hiera-gpg', {
      ensure   => 'installed',
      provider => 'gem',
    }
    )

    ensure_resource('puppet_common::add_directory', $hiera_secret_data_dir)

    file { "${hiera_secret_data_dir}/${gpg_name}.gpg":
      ensure    => file,
      source    => "puppet:///modules/${caller_module_name}/${gpg_name}.gpg",
      subscribe => Puppet_common::Add_directory[$hiera_secret_data_dir],
    }
  } else {
    notify { "No gpg configuration available for ${gpg_name} in ${caller_module_name} - existing hiera config remains."
    : }
  }
}
