class puppet_common::init_hiera ($caller_module = undef,) {
  $hiera_config_name = 'hiera.yaml'
  package { ['ruby-devel', 'gcc']: } ->
  package { ['deep_merge', 'hiera-gpg']:
    ensure   => 'installed',
    provider => 'gem',
  }

  class { 'puppet_common::variables::puppet':
  } ~>
  puppet_common::add_directory { $puppet_common::variables::puppet::conf_dir: }

  if ($caller_module) {
    file { "${puppet_common::variables::puppet::conf_dir}/${hiera_config_name}":
      ensure    => file,
      content   => template("${caller_module}/${hiera_config_name}.erb"),
      subscribe => [
        Class['Puppet_common::Variables::Puppet'],
        Puppet_common::Add_directory[$puppet_conf_dir]],
    }
  }

}