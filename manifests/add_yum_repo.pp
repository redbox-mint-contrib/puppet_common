define puppet_common::add_yum_repo ($repo = $title, $exec_path = undef,) {
  Exec {
    path      => $exec_path,
    logoutput => false,
  }

  yumrepo { $repo[name]:
    descr    => $repo[descr],
    baseurl  => $repo[baseurl],
    gpgcheck => $repo[gpgcheck],
    enabled  => $repo[enabled],
  } ~>
  exec { "${title} yum clean all": 
    command => "/usr/bin/yum clean all",
    refreshonly => true, 
  }

}
