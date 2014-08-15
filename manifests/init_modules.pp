class puppet_common::update_modules ($target_path = "/etc/puppet/Puppetfile",) {
  if (!validate_absolute_path($target_path)) {
    file { $target_path:
      ensure => file,
      source => "puppet:///modules/puppet_common/Puppetfile",
    }
  }
}