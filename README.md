vagrant-centos
==============

Want a CentOS base box for Vagrant?  Don't want a not-so-fresh feeling about downloading an untrusted one?

Create your own minimal CentOS base box for Vagrant in a few simple steps:

1. download a CentOS minimal ISO from your favorite mirror
2. run `bash vagrant-centos majorversion minorversion` (1) to create/start the VM and mini web server
3. hit TAB at the CentOS menu, append ` ks=http://HOSTIP:8000/vagrant-centos.ks` (2) (3), and hit ENTER
4. CTRL-C the web server **AFTER** the VM has automatically shut down, then wait for it to package

(1) the CentOS and guest additions ISO locations are specified in variables, and default to a Mac OS X layout<br>
(2) the Kickstart URL with dynamic host IP lookup is printed to the console<br>
(3) the Kickstart script defaults to the 'America/Chicago' time zone, which you can edit or provisioner-override

That's it! Tweak away. As-is, it only adds necessary packages for Vagrant, VirtualBox, and Puppet/Chef.

Notes: 64-bit VM, 512MB of RAM, 1GB of swap, LVM partitions, 'wheel' group, no SELinux, no firewall
