define puppet_common::update_hiera_data ($yaml_name = $title,) {
  include 'puppet_common::variables::puppet'

  if ($caller_module_name) {
    file { "${puppet_common::variables::puppet::hiera_data_dir}/${yaml_name}":
      ensure    => file,
      source    => "puppet:///modules/${caller_module_name}/${yaml_name}",
      subscribe => [Class['Puppet_common::Variables::Puppet'], Class['Puppet_common::Init_hiera']],
    }
  }
}