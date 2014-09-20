define puppet_common::update_hiera_data ($yaml_name = $title, $content = undef,) {
  class { 'puppet_common::variables::puppet': }

  if ($caller_module_name) {
    file { "${puppet_common::variables::puppet::hiera_data_dir}/${yaml_name}":
      ensure    => file,
      content   => $content ? {
        undef   => template("${caller_module_name}/${yaml_name}.erb"),
        default => $content,
      },
      subscribe => [Class['Puppet_common::Variables::Puppet'], Class['Puppet_common::Init_hiera']],
    }
  }
}
