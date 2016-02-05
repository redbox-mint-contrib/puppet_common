define puppet_common::add_yum_repo (
  $repo      = $title,
  $exec_path = hiera_array(exec_path, [
    '/usr/local/bin',
    '/opt/local/bin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin'])) {
  Exec {
    path      => $exec_path,
    logoutput => false,
  }

  ensure_packages('yum-plugin-priorities')
  yumrepo { $repo[name]:
    descr    => $repo[descr],
    baseurl  => $repo[baseurl],
    gpgcheck => $repo[gpgcheck],
    enabled  => $repo[enabled],
    priority => $repo[priority],
    require  => Package['yum-plugin-priorities'],
  } ~>
  exec { "${title} yum clean all":
    command     => "yum clean all",
    refreshonly => true,
  }

}
