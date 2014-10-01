class puppet_common::variables::puppet {
  $hiera_data_dir = "${::settings::confdir}/hiera_data"
  $hiera_secret_data_dir = "${hiera_data_dir}/secret"
}
