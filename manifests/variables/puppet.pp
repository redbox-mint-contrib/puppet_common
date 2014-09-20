class puppet_common::variables::puppet {
  $conf_dir = '/etc/puppet'
  $hiera_data_dir = "${conf_dir}/hiera_data"
  $hiera_secret_data_dir = "${hiera_data_dir}/secret"
}