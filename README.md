vagrant-centos-basebox
==============

Want a CentOS base box for Vagrant?  Don't want a not-so-fresh feeling about downloading an untrusted one?<br>
Want to maybe learn a bit more about Vagrant, VirtualBox, and Kickstart?

Create your own minimal CentOS base box for Vagrant in a few simple steps:

1. download a CentOS minimal installation ISO from your favorite mirror
2. host the 'vagrant-centos-basebox.ks' Kickstart script on a web server (1)
3. run `bash vagrant-centos-basebox 6 3` (example for CentOS 6.3) to create a clean VM
4. start it, hit TAB at the menu, append ` ks=http://webserver/vagrant-centos-basebox.ks`, hit ENTER, and wait for shutdown
5. run `vagrant package --base "$vc_basebox" --output "${vc_basebox}.box"`

(1) you might want to change the time zone from 'America/Chicago' too<br>
(2) the default variables assume Mac OS X locations for the downloaded ISO and VirtualBox guest additions<br>

That's it!  And you can see exactly what is done, and adjust it to your tastes.

Precious few variations:
* the docs suggest 360MB of RAM for base boxes, but I went with 512MB<br>
- CentOS needs more than 360MB to install, Vagrant's own lucid32 box is 512MB, and it just seems less weird to me
* the docs have no guidelines about swap, so I went with 1GB
* it uses LVM, so you can play with the partitions if you want
* the firewall is disabled (this probably isn't production...)
* SELinux is disabled (you're welcome!)
* it uses the RHEL-standard 'wheel' group instead of the Ubuntu-standard 'admin' group
