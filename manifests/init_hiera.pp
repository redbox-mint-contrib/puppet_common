class puppet_common::init_hiera {
  include 'puppet_common::variables::puppet'
  $hiera_config_name = 'hiera.yaml'

  Package {
    allow_virtual => false, }

  package { ['ruby-devel', 'gcc']: }

  package { ['deep_merge', 'hiera-gpg']:
    ensure   => 'installed',
    provider => 'gem',
  }

  puppet_common::add_directory { $puppet_common::variables::puppet::conf_dir: }

  if ($caller_module_name) {
    file { "${puppet_common::variables::puppet::conf_dir}/${hiera_config_name}":
      ensure    => file,
      content   => template("${caller_module_name}/${hiera_config_name}.erb"),
      subscribe => [
        Puppet_common::Add_directory[$puppet_common::variables::puppet::conf_dir],
        Class['Puppet_common::Variables::Puppet'],
        ],
    }
  }

}
