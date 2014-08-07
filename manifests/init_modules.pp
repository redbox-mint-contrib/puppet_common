class puppet_common::update_modules ($target_path = "/etc/puppet/Puppetfile",) {
  file { $target_path:
    ensure => file,
    source => "puppet:///modules/puppet_common/Puppetfile",
  }
}