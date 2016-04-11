define puppet_common::update_json_target_from_source (
  $target_file_path = $title,
  $source_file_path = undef,
  $source_key_path  = undef,
  $target_key_path  = undef,) {
  validate_absolute_path($source_file_path)
  validate_absolute_path("$source_file_path}/${source_key_path}")
  validate_absolute_path($target_file_path)
  validate_absolute_path("${target_file_path}/${target_key_path}")

  $source_key_value = get_file_key_path_value($source_file_path, $source_key_path)
  # just validate that it exists
  $target_key_value = get_file_key_path_value($target_file_path, $target_key_path)

  puppet_common::update_json { "${target_file_path}/${target_key_path}":
    value    => $source_key_value
  }
    
}