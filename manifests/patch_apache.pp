# == Class: puppet_common
#
# Puppet_common contains useful/utility manifests for all puppet modules
# It can also be used/modified to enable a pre-puppet environment setup
#
#
# === Authors
#
# Matt Mulholland <matt@redboxresearchdata.com.au>
#
# === Copyright
#
# Copyright (C) 2013 Queensland Cyber Infrastructure Foundation (http://www.qcif.edu.au/)
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program; if not, write to the Free Software Foundation, Inc.,
#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# # cumulative apache patches
define puppet_common::patch_apache ($config_path = undef,) {
  case $::operatingsystem {
    'centos', 'redhat', 'fedora' : { $config_path_default = '/etc/httpd/conf.d/patch.conf' }
    'default'                    : { $ssl_config_path_default = '/etc/apache2/mods-enabled/patch.conf' }
  }
  $path = $config_path ? {
    undef   => $config_path_default,
    default => $config_path,
  }

  #  https://www.apache.org/security/asf-httpoxy-response.txt
  file_line { 'LoadModule headers_module modules/mod_headers.so':
    path  => $path,
    line  => 'LoadModule headers_module modules/mod_headers.so',
    match => "^[^#]*.*mod_headers.so.*$",
  }
  #  https://www.apache.org/security/asf-httpoxy-response.txt
  file_line { 'RequestHeader unset Proxy early':
    path  => $path,
    line  => 'RequestHeader unset Proxy early',
    match => "^[^#]*.*Proxy early.*$",
  }

}
