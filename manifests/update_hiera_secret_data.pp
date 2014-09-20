define puppet_common::update_hiera_secret_data ($gpg_name = $title, $source_module = undef,) {
  require 'puppet_common::variables::puppet'

  puppet_common::add_directory { "${caller_module_name}_hiera_secret_data_dir": end_path => 
    $hiera_secret_data_dir, }

  if ($caller_module_name) {
    file { "${hiera_secret_data_dir}/${gpg_name}":
      ensure    => file,
      source    => $source_module ? {
        undef   => "puppet:///modules/${caller_module_name}/${gpg_name}",
        default => "puppet:///modules/${source_module}/${gpg_name}",
      },
      subscribe => [Class['Puppet_common::Variables::Puppet'], Class['Puppet_common::Init_hiera']],
    }
  }
}