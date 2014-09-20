define puppet_common::update_hiera_secret_data ($gpg_name = $title,) {
  require 'puppet_common::variables::puppet'

  ensure_resource('file', "$conf_dir/${hiera_config_name}", {
    ensure  => file,
    content => template("puppet_common/secret/${hiera_config_name}.erb"),
  }
  )

  ensure_resource('puppet_common::add_directory', 
  "${puppet_common::variables::puppet::hiera_secret_data_dir}")

  file { "${puppet_common::variables::puppet::hiera_secret_data_dir}/${gpg_name}":
    ensure    => file,
    source    => "puppet:///modules/${caller_module_name}/${gpg_name}",
    subscribe => Puppet_common::Add_directory[
      "${puppet_common::variables::puppet::hiera_secret_data_dir}"],
  }
}
