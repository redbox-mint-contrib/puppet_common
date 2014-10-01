class puppet_common::ntp_update (
  $include_file  = '/etc/ntp.conf',
  $timezone_path = 'usr/share/zoneinfo/Australia/Queensland',) {
  Package {
    allow_virtual => false, }

  file { '/etc/localtime':
    ensure => file,
    source => "file:////${timezone_path}",
    notify => Package['ntp'],
  }
  package { ['augeas-libs', 'augeas-devel', 'ntp']: } ->
  package { ['ruby-augeas']:
    ensure   => installed,
    provider => gem,
  } ->
  augeas { $include_file:
    incl    => $include_file,
    lens    => 'Ntp.lns',
    changes => ["ins tinker/panic before #comment[01]", "set tinker/panic 0"],
    require => [Package['ntp'], Service['ntpd']],
  }

  service { 'ntpd': ensure => running, }
}
