class puppet_common::pre_chronyd () {
  exec { 'ensure ntpd is off before chronyd runs to avoid SOCKET error message':
    command => '/sbin/service ntpd stop',
    before  => Service[chronyd],
  }
}
