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
  $archive_source    = undef,) {
  if (!$archive_source) {
    $archive_source = $archive_name
  }

  file { "${working_directory}/${archive_name}.tgz":
    owner  => $owner,
    source => "puppet:///modules/${archive_source}/${archive_name}.tgz",
  } ~>
  exec { "unpack archive ${archive_name}":
    command => "tar -xvzf ${working_directory}/${archive_name}.tgz",
    creates => "${working_directory}/${archive_name}",
    cwd     => $working_directory,
    user    => $owner,
  }
}
