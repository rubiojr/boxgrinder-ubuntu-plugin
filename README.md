# boxgrinder-ubuntu-plugin

This Boxgrinder OS plugin adds Ubuntu support to boxgrinder.

The plugin requires Ubuntu-specific tools to create the appliance so it will only work with Ubuntu as the host OS. 

Boxgrinder can be easily installed in Ubuntu via rubygems.

## Pre-requisites

**Install libguestfs binary packages**

Install libguestfs deps first:

    $ sudo apt-get install libsys-virt-perl ubuntu-vm-builder libvirt-bin \
                    rubygems libvirt-dev libxslt-dev libxml2-dev gcc make \
                    ruby-dev qemu-kvm


Grab libguestfs binary packages from:

http://libguestfs.org/download/binaries/

Download them and install them issuing the following commands:

    $ wget febootstrap_3.12-1_amd64.deb \
           guestmount_1.14.0-1_amd64.deb \
           libguestfs-dev_1.14.0-1_amd64.deb \
           libguestfs-perl_1.14.0-1_amd64.deb \
           libguestfs-tools_1.14.0-1_amd64.deb \
           libguestfs0_1.14.0-1_amd64.deb \
           python-guestfs_1.14.0-1_amd64.deb

    $ dpkg -i guestmount* libguestfs* python-guestfs*

**Install guestfs rubygem**

There are no binary packages for the libguestfs ruby bindings ATM. Grab the gem from here:

    $ wget http://rbel.frameos.org/tmp/guestfs-1.14.2.gem

    $ gem install --no-ri --no-rdoc guestfs-1.14.2.gem


**Install Boxgrinder**

    $ gem install boxgrinder-build

## Install the plugin rubygem

    gem install boxgrinder-ubuntu-plugin

## Usage

    boxgrinder-build -l boxgrinder-ubuntu-plugin myubuntu.appl

There's a sample appliance definition at:

https://github.com/rubiojr/boxgrinder-appliances/tree/master/ubuntu-natty
    
## Copyright

Copyright (c) 2011 Sergio Rubio. See LICENSE.txt for
further details.

