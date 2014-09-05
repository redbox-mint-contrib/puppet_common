
class puppet_common::init_hiera ($caller_module = undef,) {
  $hiera_config_name = 'hiera.yaml'
  package { ['ruby-devel', 'gcc']: } ->
  package { ['deep_merge', 'hiera-gpg']:
    ensure   => 'installed',
    provider => 'gem',
  }

  class { 'puppet_common::variables::puppet':
  }

  puppet_common::add_directory { $hiera_data_dir_name:
    parent_directory => $puppet_conf_dir,
    subscribe        => Class['Puppet_common::Variables::Puppet']
  }

  if ($caller_module) {
    file { "${puppet_conf_dir}/${hiera_config_name}":
      ensure    => file,
      source    => "puppet:///modules/${caller_module}/${hiera_config_name}",
      subscribe => [Class['Puppet_common::Variables::Puppet'], Puppet_common::Add_directory],
    }
  }

}