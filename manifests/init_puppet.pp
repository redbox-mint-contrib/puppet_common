class puppet_common::init_puppet (
  $puppet_conf_file = "puppet.conf",
  $home_dir         = "/root",
  $ssh_key          = undef,
  $environment      = undef,) {
  include 'puppet_common::variables::puppet'

  class { 'puppet_common::init_hiera': }

  puppet_common::add_system_user { 'puppet': }

  # set up puppet configuration file for 'root' user
  file { "${puppet_common::variables::puppet::conf_dir}/${puppet_conf_file}":
    ensure  => file,
    content => template("${module_name}/${puppet_conf_file}.erb"),
  }

  # set up ssh config so that ssh pull down from repos is always ready
  file { "${home_dir}/.ssh_agent":
    ensure  => file,
    content => template("puppet_common/ssh_agent.erb"),
  } ->
  file_line { 'agent_to_bashrc':
    path  => "${home_dir}/.bashrc",
    line  => "[[ -s ~/.ssh_agent ]] && . ~/.ssh_agent",
    match => "^[^#]*.ssh_agent$"
  }

  if (!$ssh_key) {
    notify { 'reset .ssh_agent':
      message   => "WARNING: You have reset puppet's .ssh_agent config. Update that file with the ssh key name needed for remote git repo interaction.",
      subscribe => File["${home_dir}/.ssh_agent"],
    }
  }

}