# On Debian systems, if alternatives are set, manually assign them.
class puppet_common::post_config::java () {
  case $::osfamily {
    Debian  : {
      if $puppet_common::variables::java::use_java_alternative != undef and 
      $puppet_common::variables::java::use_java_alternative_path != undef {
        exec { 'update-java-alternatives':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "update-java-alternatives --set ${puppet_common::variables::java::use_java_alternative} --jre",
          unless  => "test /etc/alternatives/java -ef '${puppet_common::variables::java::use_java_alternative_path}'",
        }
      }
    }
    default : {
      # Do nothing.
    }
  }
}
