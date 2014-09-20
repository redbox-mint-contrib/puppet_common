define puppet_common::update_hiera_data ($yaml_name = $title, $content = undef,) {
  require 'puppet_common::variables::puppet'

  ensure_resource('puppet_common::add_directory', 
  "${puppet_common::variables::puppet::hiera_data_dir}")

  file { "${puppet_common::variables::puppet::hiera_data_dir}/${yaml_name}":
    ensure    => file,
    content   => $content ? {
      undef   => template("${caller_module_name}/${yaml_name}.erb"),
      default => $content,
    },
    subscribe => Puppet_common::Add_directory["${puppet_common::variables::puppet::hiera_data_dir}"
      ],
  }
}
