#!/bin/bash

echo "This script only needs to be run ONCE to install puppet, ruby and puppet config."
echo "Press Ctl-C to exit (or any other key to continue)..."
read $temp

if [ `whoami` != 'root' ];
        then echo "this script must be executed as root" && exit 1;
fi

echo "Will attempt installation..."

## remove existing installation
reset() {
 yum remove -y ruby facter puppet
}

## install ruby installer, rvm
install_ruby() {
 curl -L get.rvm.io | bash -s stable
 /usr/local/rvm/bin/rvm install ruby-1.9.3
 /usr/local/rvm/bin/rvm pkg install zlib
 /usr/local/rvm/bin/rvm reinstall all --force
 [[ -s /usr/local/rvm/scripts/rvm ]] && source /usr/local/rvm/scripts/rvm
 rvm use 1.9.3 --default
}

## install modules required for puppet/ruby
install_puppet() {
 yum install -y augeas-libs augeas-devel compat-readline5 libselinux-ruby
 gem install ruby-augeas bundler puppet
}

reset
install_ruby
install_puppet