define puppet_common::update_hiera_data (
  $yaml_name      = $title,
  $content        = undef,
  $hiera_data_dir = "${::settings::confdir}/hiera_data") {
  ensure_resource('puppet_common::add_directory', $hiera_data_dir)

  file { "${hiera_data_dir}/${yaml_name}":
    ensure    => file,
    content   => $content ? {
      undef   => template("${caller_module_name}/${yaml_name}.erb"),
      default => $content,
    },
    subscribe => Puppet_common::Add_directory[$hiera_data_dir],
  }
}
