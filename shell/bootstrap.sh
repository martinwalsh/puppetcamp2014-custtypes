#!/bin/sh
# This bootstrap script assumes the use of a working ruby / puppet environment
apt-get update
apt-get install -y ruby-dev git

if which librarian-puppet >/dev/null; then
    echo librarian-puppet installed
else
    echo librarian-puppet not installed
    gem install librarian-puppet
    echo librarian-puppet installation complete
fi

cp /vagrant/puppet/Puppetfile /tmp/
cd /tmp && librarian-puppet install