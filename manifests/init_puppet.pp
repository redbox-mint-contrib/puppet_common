class puppet_common::init_puppet (
  $conf_file = "puppet.conf",
  $home_dir  = "/root",
  $ssh_key   = undef,) {
  $this_module_name = 'puppet_common'

  puppet_common::init_hiera { $this_module_name:
    puppet_conf_dir  => $puppet_conf_dir,
    this_module_name => $this_module_name,
  }

  # set up puppet configuration file for 'root' user
  file { "${$conf_dir}/${conf_file}":
    ensure  => file,
    # source => "puppet:///modules/${this_module_name}/${puppet_conf_file}",
    content => template("${this_module_name}/${puppet_conf_file}"),
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