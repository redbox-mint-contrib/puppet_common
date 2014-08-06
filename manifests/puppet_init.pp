class puppet_common::puppet_init (
  $conf_file  = "puppet.conf",
  $home_dir   = "/var/lib/puppet",
  $system_dir = "/etc/puppet",) {
  puppet_common::add_directory { "puppet":
    owner            => "puppet",
    parent_directory => "/etc"
  } ->
  file { $conf_file:
    path   => "${system_dir}/${conf_file}",
    ensure => file,
    source => "puppet:///modules/puppet_common/${conf_file}",
  } ->
  puppet_common::add_directory { ".puppet":
    owner            => "puppet",
    parent_directory => $home_dir
  } ->
  file { $conf_link:
    path   => "${home_dir}/.puppet",
    ensure => link,
    target => "${system_dir}",
  }

}