class puppet_common::init_hiera ($puppet_conf_dir = '/etc/puppet',) {
  puppet_common::add_directory { "hiera_data": parent_directory => $puppet_conf_dir, }

  file { "${puppet_conf_dir}/hiera.yaml":
    ensure => file,
    source => "puppet:///modules/puppet_common/hiera.yaml",
  }
}