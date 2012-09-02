vagrant-centos-basebox
==============

Want a CentOS base box for Vagrant?  Don't want a not-so-fresh feeling about downloading an untrusted one?

Create your own minimal CentOS base box for Vagrant in a few simple steps:

1. download a CentOS minimal ISO from your favorite mirror
2. run `ruby -rwebrick -e 's=WEBrick::HTTPServer.new(:Port=>8000,:DocumentRoot=>".");trap("INT") { s.shutdown }; s.start'` (1)
3. run `bash vagrant-centos-basebox 6 3` (example for CentOS 6.3) to create and start the VM (2)
4. hit TAB at the CentOS menu, append ` ks=http://HOSTIP:8000/vagrant-centos-basebox.ks`, and hit ENTER
5. run `vagrant package --base "$vc_basebox" --output "${vc_basebox}.box"` after shutdown to package

(1) the Kickstart script defaults to the 'America/Chicago' time zone, which you can edit or override with a provisioner<br>
(2) the CentOS and guest additions ISO locations are specified in variables, and default to a Mac OS X layout

That's it! Tweak away. As-is, it only adds packages which are explicitly necessary for Vagrant, VirtualBox, and Puppet/Chef.

Notes: 64-bit VM, 512MB of RAM, 1GB of swap, LVM partitions, 'wheel' group, no SELinux (you're welcome!), no firewall
