vagrant-centos-basebox
==============

Want a CentOS base box for Vagrant?  Don't want a not-so-fresh feeling about downloading an untrusted one?<br>
Want to maybe learn a bit more about Vagrant, VirtualBox, and Kickstart?

Create your own minimal CentOS base box for Vagrant in a few simple steps:

1. download a CentOS minimal installation ISO from your favorite mirror
2. host the 'vagrant-centos-basebox.ks' Kickstart script on a local web server (1)
3. edit 'vagrant-centos-basebox.vars' as appropriate (2)
4. run `. ./vagrant-centos-basebox.vars`
5. run `bash vagrant-centos-basebox` to create a clean VM
6. start the VM, hit TAB at the first prompt, and append `ks=http://yourwebserver/vagrant-centos-basebox.ks`
7. wait for the VM to complete its Kickstart installation and shut down
8. run `VBoxManage modifyvm "$basebox" --memory 360` to take the VM's memory down to 360MB (3)(4)
9. run `vagrant package --base "$basebox" --output "${basebox}.box"`

(1) you might want to change the time zone from 'USA/Chicago' too<br>
(2) the defaults use my Github username, and the file paths are for Mac OS X<br>
(3) doc-suggested distribution standard. CentOS needs more to install, but runs fine with it once installed.<br>
(4) I use a custom '~/.vagrant.d/Vagrantfile' to override all boxes with 1GB and point to a common Puppet manifest

That's it!  And you can see exactly what is done, and adjust it to your tastes.

The VM starts with the same defaults as a GUI-created VM, modeled according to the docs

The Kickstart script is also doc-modeled, although there are some minor/contextual adjustments
* It has a 1GB swap partition - the docs don't say anything about swap
* It uses LVM, so you can play with the partitions if you want
* The firewall is disabled (do you want a firewall interfering on a Vagrant VM?)
* SELinux is disabled (you're welcome!)
* It uses the RHEL-standard 'wheel' group instead of the Ubuntu-standard 'admin' group
