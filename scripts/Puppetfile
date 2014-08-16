#!/usr/bin/env ruby
#^syntax detection

## To use with librarian-puppet (or r10k).
# Typically the steps to set this up are
# gem install librarian-puppet
# cd $(puppet config print confdir)
# librarian-puppet init
# <<Then clobber default Puppetfile with this one>>
# librarian-puppet install (this will install modules below)
# Then to update modules from git, remove Puppetfile.lock, before running install again.

forge "https://forgeapi.puppetlabs.com"

# use dependencies defined in metadata.json
#metadata

# use dependencies defined in Modulefile
# modulefile

mod 'puppetlabs/stdlib', "4.1.0"
mod 'qcif-puppet_common',
   :git => "git://github.com/redbox-mint-contrib/puppet_common.git"
