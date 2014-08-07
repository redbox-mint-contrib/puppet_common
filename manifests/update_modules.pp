class puppet_common::update_modules ($target_path = "/etc/puppet/Puppetfile", $modules = undef,) {
  $modules.each |$key, $value| {
    file_line { $key:
      path => $target_path,
      line => $value,
    }
  }

}
