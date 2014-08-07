class puppet_common::init_puppet (
  $conf_file = "puppet.conf",
  $home_dir  = "/var/lib/puppet",
  $conf_dir  = "/etc/puppet",) {
  # set up puppet configuration file

  puppet_common::add_directory { "hiera_data": parent_directory => $conf_dir, } ->
  file { "${$conf_dir}/${conf_file}":
    ensure => file,
    source => "puppet:///modules/puppet_common/${conf_file}",
  } ->
  file { "${home_dir}/.puppet":
    ensure => link,
    target => "${conf_dir}",
  } -> notify { 'reset puppet.conf': message => "WARNING: You have reset puppet's conf file." } ->
  file { "${conf_dir}/hiera.yaml":
    ensure => file,
    source => "puppet:///modules/puppet_common/hiera.yaml",
  }
  # set up .bashrc for use with non-login puppet user.
  file { "${home_dir}/.bashrc":
    ensure => file,
    source => "puppet:///modules/puppet_common/bashrc",
  } -> notify { 'reset .bashrc': message => "WARNING: You have reset puppet's .bashrc file." }

}