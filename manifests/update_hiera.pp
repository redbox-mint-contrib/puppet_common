define puppet_common::update_hiera ($module_name = $title, $puppet_conf_dir = '/etc/puppet', $yaml_names = undef,) {
  $yaml_names.each |$value| {
    file { "${puppet_conf_dir}/${module_name}":
      ensure  => file,
      source  => "puppet:///modules/${module_name}/${value}",
      require => Class['puppet_common::hiera_init']
    }
  }

}