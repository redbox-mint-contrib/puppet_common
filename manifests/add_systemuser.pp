define puppet_common::add_systemuser ($username = $title, $shell = '/bin/bash', $home_parent = "/home") {
  user { $username:
    ensure     => present,
    home       => "${home_parent}/$username",
    shell      => $shell,
    system     => true,
    managehome => true,
  }

}
