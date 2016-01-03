vagrant-centos
==============

Want a CentOS base box for Vagrant? Maybe a custom one? Don't want to download something untrusted? This will fire up a VirtualBox VM and a Ruby-based web server for hosting Kickstart automated installation scripts. Sane and minimal defaults are used, and it's easy to customize while learning about your tooling along the way.

Create your own minimal CentOS base box for Vagrant in a few simple steps:

1. download a CentOS 6 or 7 x64 minimal ISO from your favorite mirror
2. run `bash vagrant-centos majorversion [minorversion]` (1) to create/start the VM and mini web server
3. hit TAB at the CentOS menu and append ` ks=http://HOSTIP:8000/vagrant-centos-MAJORVERSION.ks` (2)
4. CTRL-C the web server **AFTER** the VM has automatically shut down, then wait for it to package
5. run `vagrant box add vagrant-centos-VERSION.box --name YOURNAME` to register the box

(1) the CentOS and guest additions ISO locations are specified in variables, and default to a Mac OS X layout<br>
(2) the Kickstart URL with dynamic host IP lookup is printed to the console<br>

That's it! Tweak away. As-is, it only adds necessary packages for Vagrant, VirtualBox, and Puppet/Chef/Ansible.

Notes: 64-bit VM, 512MB of RAM, 1GB of swap, 40GB of LVM HDD, 'wheel' group, no SELinux, no firewall.

Requirements: Bash, Ruby, VirtualBox, and Vagrant. Only tested on Mac OS X.
