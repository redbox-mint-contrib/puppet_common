class puppet_common::init_puppet ($conf_file = "puppet.conf", $home_dir = "/root", $conf_dir = "/etc/puppet",) {
  # set up puppet configuration file

  puppet_common::add_directory { "hiera_data": parent_directory => $conf_dir, } ->
  file { "${$conf_dir}/${conf_file}":
    ensure => file,
    source => "puppet:///modules/puppet_common/${conf_file}",
  } ->
  file { "${conf_dir}/hiera.yaml":
    ensure => file,
    source => "puppet:///modules/puppet_common/hiera.yaml",
  }

  file { "${home_dir}/.ssh_agent":
    ensure => file,
    source => "puppet:///modules/puppet_common/ssh_agent",
  } -> notify { 'reset .ssh_agent': message => "WARNING: You have reset puppet's .ssh_agent config." } ->
  file_line { 'agent_to_bashrc':
    path  => "${home_dir}/.bashrc",
    line  => "[[ -s ~/.ssh_agent ]] && ~/.ssh_agent",
    match => "^.*&& ~/.ssh_agent$"
  }

}