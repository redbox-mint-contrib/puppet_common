define puppet_common::add_directory ($end_path = $title, $owner, $parent_directory = undef, $mode = '0750') {
  $full_path = "${parent_directory}/${end_path}"

  create_parent_directories($full_path)

  file { ["${parent_directory}", "${full_path}"]:
    ensure  => directory,
    owner   => $owner,
    group   => $owner,
    mode    => $mode,
    require => Puppet_common::Add_systemuser[$owner],
  }
}