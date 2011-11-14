# boxgrinder-ubuntu-plugin

This Boxgrinder OS plugin adds Ubuntu support to boxgrinder.

The plugin requires Ubuntu-specific tools to create the appliance so it will only work with Ubuntu as the host OS. 

Boxgrinder can be easily installed in Ubuntu via rubygems.

## Pre-requisites

**Install libguestfs binary packages**

Install libguestfs deps first:

    $ sudo apt-get install libsys-virt-perl ubuntu-vm-builder libvirt-bin \
                    rubygems libvirt-dev libxslt-dev libxml2-dev gcc make \
                    ruby-dev qemu-kvm augeas-lenses btrfs-tools cryptsetup \
                    diff jfsutils libaugeas0 libhivex0 libntfs10 ntfsprogs \
                    reiserfsprogs scrub xfsprogs zerofree zfs-fuse


Grab libguestfs binary packages from:

http://libguestfs.org/download/binaries/

For **Ubuntu Natty**, download them and install them issuing the following commands:

    $ wget -r -l1 -H -t1 -nd -N -np -A.deb http://libguestfs.org/download/binaries/ubuntu1104-packages/

Remove not required packages:

    $ rm *ocaml*deb libguestfs-doc* libguestfs0-dbg*

Install libguestfs packages:

    $ dpkg -i guestmount* libguestfs* python-guestfs*

**Install guestfs rubygem**

There are no binary packages for the libguestfs ruby bindings ATM. Grab the gem from here:

    $ wget http://rbel.frameos.org/tmp/guestfs-1.14.2.gem

    $ sudo gem install --no-ri --no-rdoc guestfs-1.14.2.gem


**Install Boxgrinder and the Ubuntu plugin**

    $ sudo gem install --no-ri --no-rdoc boxgrinder-build boxgrinder-ubuntu-plugin

## Usage

    boxgrinder-build -l boxgrinder-ubuntu-plugin ubuntu.appl

There's a sample appliance definition at:

https://github.com/rubiojr/boxgrinder-appliances/tree/master/ubuntu-natty
    
## Copyright

Copyright (c) 2011 Sergio Rubio. See LICENSE.txt for
further details.

