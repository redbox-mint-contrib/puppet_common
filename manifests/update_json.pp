define puppet_common::update_json ($path = $title, $value = undef,) {
  if empty($value) {
    fail("A source value is required")
  }

  $augeas_key_path = key_path_to_augeas_json($path)

  $load_path = "${module_name}/lib/augeas/lenses"

  ensure_packages('augeas')

  # TODO: test can use augeas with full path as augeas set
  augeas { $path:
    load_path => $load_path,
    #    incl      => $file_path,
    lens      => 'Custom_json.lns',
    changes   => ["set ${augeas_key_path}/string \"${value}\""],
    require   => Package['augeas'],
  }

}
