define puppet_common::update_hiera_data ($yaml_name = $title, $content = undef,) {
  include 'puppet_common::variables::puppet'

  puppet_common::add_directory { "${caller_module_name}_hiera_data_dir": end_path => 
    $puppet_common::variables::puppet::hiera_data_dir, }

  if ($caller_module_name) {
    file { "${puppet_common::variables::puppet::hiera_data_dir}/${yaml_name}":
      ensure    => file,
      content   => $content ? {
        undef   => template("${caller_module_name}/${yaml_name}"),
        default => $content,
      },
      subscribe => [Class['Puppet_common::Variables::Puppet'], Class['Puppet_common::Init_hiera']],
    }
  }
}
