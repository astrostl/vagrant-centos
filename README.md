vagrant-centos-basebox
==============

Want a CentOS base box for Vagrant?  Don't want a not-so-fresh feeling about downloading an untrusted one?

Create your own minimal CentOS base box for Vagrant in a few simple steps:

1. download a CentOS minimal ISO from your favorite mirror
2. run `bash vagrant-centos-basebox majorversion minorversion` (1) to create and start the VM and WEBrick web server
3. hit TAB at the CentOS menu, append ` ks=http://HOSTIP:8000/vagrant-centos-basebox.ks` (2), and hit ENTER
4. CTRL-C the web server and run `vagrant package --base "$vc_basebox" --output "${vc_basebox}.box"` after shutdown to package

(1) the CentOS and guest additions ISO locations are specified in variables, and default to a Mac OS X layout<br>
(2) the Kickstart script defaults to the 'America/Chicago' time zone, which you can edit or override with a provisioner

That's it! Tweak away. As-is, it only adds packages which are explicitly necessary for Vagrant, VirtualBox, and Puppet/Chef.

Notes: 64-bit VM, 512MB of RAM, 1GB of swap, LVM partitions, 'wheel' group, no SELinux (you're welcome!), no firewall
