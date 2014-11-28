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
define puppet_common::patch_ssl (
  $ssl_config_path = undef,
  $file_line       = 'SSLProtocol all -SSLv2 -SSLv3',) {
  case $::operatingsystem {
    'centos', 'redhat', 'fedora' : {
      $ssl_config_path_default = '/etc/httpd/conf.d/ssl.conf'
    }
    'default'                    : {
      $ssl_config_path_default = '/etc/apache2/mods-enabled/ssl.conf'
    }
  }

  file_line { $file_line:
    path  => $ssl_config_path ? {
      undef   => $ssl_config_path_default,
      default => $ssl_config_path,
    },
    line  => $file_line,
    match => "^[^#]*SSLProtocol.*$"
  }
}
