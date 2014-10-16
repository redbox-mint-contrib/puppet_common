define puppet_common::add_yum_repo ($repo = $title, $exec_path = undef,) {
  if ($exec_path) {
    Exec {
      path      => $exec_path,
      logoutput => false,
    }
  }
  yumrepo { $repo[name]:
    descr    => $repo[descr],
    baseurl  => $repo[baseurl],
    gpgcheck => $repo[gpgcheck],
    enabled  => $repo[enabled],
  } ~>
  exec { 'yum clean all': refreshonly => true, }

}
