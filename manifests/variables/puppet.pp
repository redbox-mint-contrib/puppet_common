class puppet_common::variables::puppet {
  $hiera_data_dir = "\"${::settings::confdir}/environments/%{environment}/hiera_data\""
  $hiera_secret_data_dir = "\"${::settings::confdir}/environments/%{environment}/hiera_data/secret\""
}
