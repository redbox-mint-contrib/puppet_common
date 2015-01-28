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

define puppet_common::deploy_archive (
  $archive_name      = $title,
  $owner             = undef,
  $working_directory = undef,
  $module_source     = undef,
  $archive_extension = '.tar.gz',
  $unpack_owner      = undef,
  $mode              = '0750') {
  $archive_source = $module_source ? {
    undef   => $archive_name,
    default => $module_source,
  }

  file { "${working_directory}/${archive_name}${archive_extension}":
    owner  => $owner,
    source => "puppet:///modules/${archive_source}/${archive_name}${archive_extension}",
    mode   => 0744,
  } ~>
  exec { "unpack archive ${archive_name}":
    command => "tar -xvzf ${working_directory}/${archive_name}${archive_extension}",
    creates => "${working_directory}/${archive_name}",
    cwd     => $working_directory,
    user    => $unpack_owner ? {
      undef   => $owner,
      default => $unpack_owner,
    }
  }
  ensure_resource('file', "${working_directory}/${archive_name}", {
    ensure  => directory,
    recurse => true,
    owner   => $owner,
    group   => $owner,
    require => Exec["unpack archive ${archive_name}"],
  }
  )

}
