class puppet_common::update_modules ($target_path = "/etc/puppet/Puppetfile", $modules = hiera_array(modules, undef),) {
  class { 'puppet_common::init_modules': }

  $modules.each |$key, $value| {
    file_line { $key:
      path      => $target_path,
      line      => $value,
      match     => $value,
      subscribe => [Class['puppet_common::init_modules']]
    }
  }

}
