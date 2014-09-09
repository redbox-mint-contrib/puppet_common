class puppet_common::variables::puppet {
  $puppet_conf_dir = '/etc/puppet'
  $hiera_data_dir = "${puppet_conf_dir}/hiera_data"
}