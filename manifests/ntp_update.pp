class puppet_common::ntp_update (
  $include_file  = '/etc/ntp.conf',
  $timezone_path = '/usr/share/zoneinfo/Australia/Queensland',) {
  Package {
    allow_virtual => false, }

  case $::osfamily {
    default  : {
      fail("unsupported platform ${::osfamily}")
    }
    'RedHat' : {
      case $::operatingsystem {
        default            : {
          fail("unsupported os ${::operatingsystem}")
        }
        'RedHat', 'CentOS' : {
          package { ['augeas-libs', 'augeas-devel']: before => Augeas[$include_file] }
          $local_timezone_path = $timezone_path
          $ntp_service_name = 'ntpd'
        }
      }
    }
    'Debian' : {
      package { ['libaugeas-ruby', 'libaugeas-dev']: before => Augeas[$include_file] }
      $ntp_service_name = 'ntp'

      case $::lsbdistcodename {
        default            : { $local_timezone_path = $timezone_path }
        'raring', 'trusty' : { $local_timezone_path = '/usr/share/zoneinfo/Australia/Brisbane' }
      }
    }
  }

  file { '/etc/localtime':
    ensure => file,
    source => "file://${local_timezone_path}",
    notify => Package['ntp'],
  }

  package { 'ntp': }

  augeas { $include_file:
    incl    => $include_file,
    lens    => 'Ntp.lns',
    changes => ["ins tinker before #comment[01]", "set tinker/panic 0"],
    require => Package['ntp'],
    notify  => Service[$ntp_service_name],
  }

  service { $ntp_service_name:
    ensure  => running,
    require => Package['ntp']
  }
}
