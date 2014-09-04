define puppet_common::update_hiera (
  $yaml_name       = $title,
  $puppet_conf_dir = '/etc/puppet',
  $caller_module   = undef,) {
  $hiera_data_dir = "${puppet_conf_dir}/hiera_data"

  if ($caller_module) {
    $yaml_names.each |$value| {
      file { "${hiera_data_dir}/${value}":
        ensure  => file,
        source  => "puppet:///modules/${caller_module}/${value}",
        require => Class['Puppet_common::Init_hiera'],
      }
    }
  }
}