class puppet_common::puppet_init (
  $conf_file  = "puppet.conf",
  $home_dir   = "/var/lib/puppet",
  $system_dir = "/etc/puppet",) {
  # set up puppet configuration file
  puppet_common::add_directory { "puppet":
    owner            => "puppet",
    parent_directory => "/etc"
  } ->
  file { "${system_dir}/${conf_file}":
    ensure => file,
    source => "puppet:///modules/puppet_common/${conf_file}",
  } ->
  puppet_common::add_directory { ".puppet":
    owner            => "puppet",
    parent_directory => $home_dir
  } ->
  file { "${home_dir}/.puppet":
    ensure => link,
    target => "${system_dir}",
  } -> notify { 'reset puppet.conf': message => "WARNING: You have reset puppet's conf file." }

  # set up .bashrc for use with non-login puppet user.
  file { "${home_dir}/.bashrc":
    ensure => file,
    source => "puppet:///modules/puppet_common/bashrc",
  } -> notify { 'reset .bashrc': message => "WARNING: You have reset puppet's .bashrc file." }

}