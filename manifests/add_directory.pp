define puppet_common::add_directory (
  $end_path         = $title,
  $owner            = 'root',
  $parent_directory = undef,
  $mode             = '0750') {
  $full_path = "${parent_directory}/${end_path}"

  create_parent_directories($full_path)

  if ($parent_directory) {
    ensure_resource(file, $parent_directory, {
      ensure => directory,
      owner  => $owner,
      group  => $owner,
      mode   => $mode,
    }
    )
  }

  ensure_resource(file, $full_path, {
    ensure => directory,
    owner  => $owner,
    group  => $owner,
    mode   => $mode,
  }
  )
}
