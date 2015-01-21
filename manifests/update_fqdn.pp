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
class puppet_common::update_fqdn (
  $updated_fqdn         = undef,
  $hostname_config_path = '/etc/sysconfig/network',
  $domain_config_path   = '/etc/resolv.conf',
  $hosts_path           = '/etc/hosts',
  $exec_path            = hiera_array(exec_path, [
    '/usr/local/bin',
    '/usr/local/sbin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin',
    '/usr/local/rvm/rubies/ruby-2.1.4/bin']),) {
  Exec {
    path      => $exec_path,
    logoutput => true,
  }

  $array_fqdn = split($updated_fqdn, '[.]')
  $updated_domain = join(delete_at($array_fqdn, 0), ".")
  $current_fqdn = $::fqdn

  # # updating network like this needs to be done carefully - no blank variables allowed and ensure
  # existing entries are removed - NB:
  #  -  restarting network will update resolv.conf with existing domain, overwriting any single
  #  entries created. This is OK as long as new domain is added to 'search'
  #   - because puppet is already running, the new entries cannot be seen until next puppet run
  if ($updated_fqdn and $::fqdn != $updated_fqdn and strip($updated_fqdn) != '' and $updated_domain 
  and strip($updated_domain) != '') {
    augeas { $hosts_path:
      incl    => $hosts_path,
      lens    => 'Hosts.lns',
      changes => ["rm *[ipaddr =~ regexp(\"${::ipaddress}\")]"]
    } ->
    host { 'add ip ':
      name   => $updated_fqdn,
      ensure => present,
      ip     => $::ipaddress,
    } ->
    augeas { $domain_config_path:
      incl    => $domain_config_path,
      lens    => 'Resolv.lns',
      changes => [
        "rm search/domain",
        "set domain ${updated_domain}",
        "set search/domain ${updated_domain}"],
    } ->
    file_line { "update ${hostname_config_path}":
      path  => $hostname_config_path,
      line  => "HOSTNAME=${updated_fqdn}",
      match => "^HOSTNAME=.*$",
    } -> exec { ["hostname ${updated_fqdn} &&
      service network restart"]: }
  } else {
    notify { "No fqdn supplied or fqdn unchanged for network update. Current fqdn:
      ${::fqdn} New fqdn supplied: ${updated_fqdn}": }
  }
}
