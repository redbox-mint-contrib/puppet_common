define puppet_common::add_directory (
  $end_path         = $title,
  $owner            = 'root',
  $parent_directory = undef,
  $mode             = '0750') {
  $full_path = "${parent_directory}/${end_path}"

  create_parent_directories($full_path)

  if ($parent_directory) {
    file { "${parent_directory} for ${full_path}":
      path   => $parent_directory,
      ensure => directory,
      owner  => $owner,
      group  => $owner,
      mode   => $mode,
    }
  }

  file { "${full_path}":
    ensure => directory,
    owner  => $owner,
    group  => $owner,
    mode   => $mode,
  }
}
