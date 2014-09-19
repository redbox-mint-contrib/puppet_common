define puppet_common::update_hiera_secret_data ($gpg_name = $title,) {
  include 'puppet_common::variables::puppet'

  $hiera_secret_data_dir = "${hiera_data_dir}/secret"

  puppet_common::add_directory { "${caller_module_name}_hiera_secret_data_dir": end_path => 
    $hiera_secret_data_dir, }

  if ($caller_module_name) {
    file { "${hiera_secret_data_dir}/${gpg_name}":
      ensure    => file,
      source    => "puppet:///modules/${caller_module_name}/${gpg_name}",
      subscribe => [Class['Puppet_common::Variables::Puppet'], Class['Puppet_common::Init_hiera']],
    }
  }
}