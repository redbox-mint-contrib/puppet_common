define puppet_common::add_directory (
  $end_path         = $title,
  $owner            = 'root',
  $parent_directory = undef,
  $mode             = '0750') {
  $full_path = "${parent_directory}/${end_path}"

  create_parent_directories($full_path)

  # parent directory is an optional argument
  $dir_array = delete_undef_values([$parent_directory, $full_path])

  file { $dir_array:
    ensure => directory,
    owner  => $owner,
    group  => $owner,
    mode   => $mode,
  }
}