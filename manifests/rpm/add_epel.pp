class puppet_common::rpm::add_epel (
  $base_url = 'download.fedoraproject.org/pub/epel',
  $rpm_name = 'epel-release-6-8',) {
  exec { $rpm_name:
    command   => "rpm -Uvh http://${base_url}/${rpm_name}/${::operatingsystemmajrelease}/${::architecture}/${rpm_name}.noarch.rpm",
    tries     => 2,
    try_sleep => 3,
    user      => 'root',
    logoutput => true,
    creates   => '/etc/yum.repos.d/epel.repo',
  }
}
