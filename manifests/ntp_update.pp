class puppet_common::ntp_update ($include_file = '/etc/ntp.conf',) {
  Package {
    allow_virtual => false, } ->
  file { '/etc/localtime':
    ensure => file,
    source => 'file:////usr/share/zoneinfo/Australia/Queensland',
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
    changes => [
      "ins tinker before /files/home/ec2-user/ntp.conf/#comment[01]",
      "set dict/entry[. = 'rapidAafSso']/dict/entry[. = 'url']/string \"${system_config[rapidAafSso]
        [url]}\"",
      "set dict/entry[. = 'rapidAafSso']/dict/entry[. = 'sharedKey']/string \"${system_config[
          rapidAafSso][sharedKey]}\""],
    require => [Package['ntp'], Service['ntpd']],
  }

  service { 'ntpd': ensure => running, }
}
