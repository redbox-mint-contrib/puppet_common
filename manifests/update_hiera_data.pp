define puppet_common::update_hiera_data (
  $yaml_name        = $title,
  $content          = undef,
  $environment_name = undef) {
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

  if ($environment) {
    file_line { 'set puppet.conf environment':
      path  => "${puppet_common::variables::puppet::conf_dir}/${puppet_common::variables::puppet::hiera_config_name}",
      line  => "environment=${environment_name}",
      match => "^[\\s]*environment[\\s]*=[\\s]*[a-zA-Z]+$"
    }
  }
}
