class puppet_common::java ($version = 'present',) {
  class { 'puppet_common::variables::java': } ->
  package { 'java':
    ensure => $version,
    name   => $variables::java::use_java_package_name,
  } ->
  class { 'puppet_common::post_config::java': }

}
