class puppet_common::variables {
  $puppet_conf_dir = '/etc/puppet', $hiera_data_dir_name = 'hiera_data', $hiera_data_dir = 
  "${puppet_conf_dir}/${hiera_data_dir_name}"
}