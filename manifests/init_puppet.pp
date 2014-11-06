class puppet_common::init_puppet (
  $home_dir      = "/root",
  $ssh_key       = undef,
  $environment   = undef,
  $puppet_user   = 'puppet',
  $puppet_master = undef,) {
  require 'puppet_common::variables::puppet'

  host { [$::fqdn]: ip => $::ipaddress, }

  class { 'puppet_common::ntp_update': }

  class { 'puppet_common::init_hiera': }

  # some modules already setup with dedicated 'puppet' user - create this as temp work-around.
  puppet_common::add_systemuser { $puppet_user: } ->
  # set up puppet configuration file for 'root' user
  file { 'puppetize config dir':
    path    => $::settings::confdir,
    ensure  => directory,
    owner   => $puppet_user,
    recurse => true,
  } ->
  file { $::settings::config:
    ensure  => file,
    content => template("${module_name}/${::settings::config_file_name}.erb"),
    owner   => $puppet_user,
  } ->
  file { "${::settings::confdir}/gpg":
    ensure  => directory,
    owner   => $puppet_user,
    recurse => true,
  } ->
  notify { "Gpg directory has been created. Ensure you import or create keys with '--homedir' set to ${::settings::confdir}/gpg"
  : }

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
