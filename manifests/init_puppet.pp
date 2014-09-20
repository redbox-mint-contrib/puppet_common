class puppet_common::init_puppet (
  $puppet_conf_file = "puppet.conf",
  $home_dir         = "/root",
  $ssh_key          = undef,
  $environment      = undef,
  $puppet_user      = 'puppet',) {
  include 'puppet_common::variables::puppet'

  host { [$::fqdn]: ip => $::ipaddress, }

  class { 'puppet_common::init_hiera': }

  # some modules already setup with dedicated 'puppet' user - create this as temp work-around.
  puppet_common::add_systemuser { $puppet_user: }

  # set up puppet configuration file for 'root' user
  puppet_common::add_directory { $puppet_common::variables::puppet::conf_dir: } ->
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