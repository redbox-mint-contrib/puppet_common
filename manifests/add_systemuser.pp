define puppet_common::add_systemuser (
  $username           = $title,
  $shell              = '/bin/bash',
  $home_parent_dir    = "/home",
  $ssh_authorized_key = undef,) {
  user { $username:
    ensure     => present,
    home       => "${home_parent_dir}/$username",
    shell      => $shell,
    system     => true,
    managehome => true,
  }

  if ($ssh_authorized_key) {
    ssh_authorized_key { $username:
      user => $username,
      type => 'ssh-rsa',
      key  => $ssh_authorized_key,
    }
  }

}
