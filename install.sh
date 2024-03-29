#!/bin/bash

# This runs as root on the server

chef_binary=/var/lib/gems/1.9.1/gems/chef-10.16.4/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    aptitude update &&
    apt-get -o Dpkg::Options::="--force-confnew" \
        --force-yes -fuy dist-upgrade &&
    # Install Ruby and Chef
    aptitude install -y ruby1.9.1 ruby1.9.1-dev make &&
	
	sudo gem1.9.1 install net-ssh -v 2.2.2 --no-ri --no-rdoc
	sudo gem1.9.1 install net-ssh-gateway -v 1.1.0 --no-ri --no-rdoc --ignore-dependencies
	sudo gem1.9.1 install net-ssh-multi -v 1.1.0 --no-ri --no-rdoc --ignore-dependencies
	
    sudo gem1.9.1 install --no-rdoc --no-ri chef --version 10.16.4
fi &&

sudo "$chef_binary" -c solo.rb -j solo.json