class puppet_common::init_puppet ($conf_file = "puppet.conf", $home_dir = "/root", $conf_dir = "/etc/puppet",) {
  # set up puppet configuration file for 'root' user
  puppet_common::add_directory { "hiera_data": parent_directory => $conf_dir, } ->
  file { "${$conf_dir}/${conf_file}":
    ensure => file,
    source => "puppet:///modules/puppet_common/${conf_file}",
  } ->
  # set up hiera basics
  file { "${conf_dir}/hiera.yaml":
    ensure => file,
    source => "puppet:///modules/puppet_common/hiera.yaml",
  }

  # set up ssh config so ssh pull down from repos always ready
  file { "${home_dir}/.ssh_agent":
    ensure => file,
    source => "puppet:///modules/puppet_common/ssh_agent",
  } -> notify { 'reset .ssh_agent': message => "WARNING: You have reset puppet's .ssh_agent config. Update that file with the ssh key needed for remote git repo interaction." 
  } ->
  file_line { 'agent_to_bashrc':
    path  => "${home_dir}/.bashrc",
    line  => "[[ -s ~/.ssh_agent ]] && . ~/.ssh_agent",
    match => "^[^#]*.ssh_agent$"
  }

}