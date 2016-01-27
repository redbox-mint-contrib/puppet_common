define puppet_common::add_directory (
  $end_path         = $title,
  $owner            = 'root',
  $parent_directory = undef,
  $recurse          = false,
  $mode             = '0750') {
  if ($parent_directory) {
    create_parent_directories($full_path)

    ensure_resource(file, $parent_directory, {
      ensure  => directory,
      owner   => $owner,
      recurse => $recurse,
      group   => $owner,
      mode    => $mode,
    }
    )
    $full_path = "${parent_directory}/${end_path}"
  } else {
    $full_path = $end_path
  }

  ensure_resource(file, $full_path, {
    ensure  => directory,
    recurse => $recurse,
    owner   => $owner,
    group   => $owner,
    mode    => $mode,
  }
  )
}
