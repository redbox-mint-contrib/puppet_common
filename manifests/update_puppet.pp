define puppet_common::update_puppet ($file_name = $title, $content = undef,) {
  $parent_dir = dirname($file_name)
  ensure_resource('puppet_common::add_directory', $parent_dir)

  file { $file_name:
    ensure    => file,
    content   => $content ? {
      undef   => template("${caller_module_name}/${file_name}.erb"),
      default => $content,
    },
    subscribe => Puppet_common::Add_directory[$parent_dir],
  }
}
