
class puppet_common::init_hiera (
  $caller_module       = undef,
  $puppet_conf_dir     = '/etc/puppet',
  $hiera_config_name   = 'hiera.yaml',
  $hiera_data_dir_name = "hiera_data",) {
  package { ['ruby-devel', 'gcc']: } ->
  package { ['deep_merge', 'hiera-gpg']:
    ensure   => 'installed',
    provider => 'gem',
  }

  puppet_common::add_directory { $hiera_data_dir_name: parent_directory => $puppet_conf_dir, }

  if ($caller_module) {
    file { "${puppet_conf_dir}/${hiera_config_name}":
      ensure  => file,
      source  => "puppet:///modules/${caller_module}/${hiera_config_name}",
      require => Puppet_common::Add_directory,
    }
  }

}