define puppet_common::update_hiera_data ($yaml_name = $title, $caller_module = undef,) {
  class { 'puppet_common::variables::puppet': } ~>
  puppet_common::add_directory { $puppet_common::variables::puppet::hiera_data_dir: }

  if ($caller_module) {
    $yaml_names.each |$value| {
      file { "${puppet_common::variables::puppet::hiera_data_dir}/${value}":
        ensure    => file,
        source    => "puppet:///modules/${caller_module}/${value}",
        subscribe => [
          Class['Puppet_common::Variables::Puppet'],
          Class['Puppet_common::Init_hiera']],
      }
    }
  }
}