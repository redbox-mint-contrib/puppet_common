#!/bin/bash

usage() {
	if [ `whoami` != 'root' ]; 
		then echo "this script must be executed as root" && exit 1;
	fi
}
usage

## remove existing installation
yum remove -y ruby facter puppet

## install ruby installer, rvm
curl -L get.rvm.io | bash -s stable
/usr/local/rvm/bin/rvm install ruby-1.9.3
/usr/local/rvm/bin/rvm pkg install zlib
/usr/local/rvm/bin/rvm reinstall all --force
[[ -s /usr/local/rvm/scripts/rvm ]] && source /usr/local/rvm/scripts/rvm

## install modules required
yum install -y augeas-libs augeas-devel compat-readline5 libselinux-ruby git
rvm use 1.9.3 --default
gem install ruby-augeas bundler r10k puppet