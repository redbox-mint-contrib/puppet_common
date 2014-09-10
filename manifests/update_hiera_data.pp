define puppet_common::update_hiera_data ($yaml_name = $title,) {
  class { 'puppet_common::variables::puppet': } ~>
  puppet_common::add_directory { $puppet_common::variables::puppet::hiera_data_dir: }

  if ($caller_module_name) {
    $yaml_names.each |$value| {
      file { "${puppet_common::variables::puppet::hiera_data_dir}/${value}":
        ensure    => file,
        source    => "puppet:///modules/${caller_module_name}/${value}",
        subscribe => [
          Class['Puppet_common::Variables::Puppet'],
          Class['Puppet_common::Init_hiera']],
      }
    }
  }
}