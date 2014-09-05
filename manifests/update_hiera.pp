define puppet_common::update_hiera ($yaml_name = $title, $caller_module = undef,) {
  class { 'puppet_common::variables::puppet': }

  if ($caller_module) {
    $yaml_names.each |$value| {
      file { "${hiera_data_dir}/${value}":
        ensure    => file,
        source    => "puppet:///modules/${caller_module}/${value}",
        subscribe => [
          Class['Puppet_common::Variables::Puppet'],
          Class['Puppet_common::Init_hiera']],
      }
    }
  }
}