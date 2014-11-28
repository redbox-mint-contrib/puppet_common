class puppet_common::rpm::add_remi (
  $base_url = 'rpms.famillecollet.com/enterprise',
  $rpm_name = 'remi-release',) {
  exec { $rpm_name:
    command   => "rpm -Uvh http://${base_url}/${rpm_name}-${::operatingsystemmajrelease}.rpm",
    tries     => 2,
    try_sleep => 3,
    user      => 'root',
    logoutput => true,
    creates   => '/etc/yum.repos.d/remi.repo',
  }
}
