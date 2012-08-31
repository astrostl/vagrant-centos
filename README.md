vagrant-centos
==============

Want a CentOS base box?  Don't want a not-so-fresh feeling about downloading one?<br>
Want to maybe learn a bit more about Vagrant, VirtualBox, and Kickstart?

Create your own minimal CentOS Base Box for Vagrant in a few simple steps:

1. download a CentOS minimal installation ISO from your favorite mirror
2. host the 'vagrant-centos-basebox.ks' Kickstart script on a local web server (1)
3. edit the 'vagrant-centos-basebox' script's location variables as appropriate (2)
4. run `bash vagrant-centos-basebox` to create a clean VM
5. start the VM, hit TAB at the first prompt, and append `ks=http://yourwebserver/vagrant-centos-basebox.ks`
6. wait for the VM to complete its Kickstart installation and shut down
7. run `VBoxManage modifyvm "$basebox" --memory 360` to take the VM's memory down to 360MB (3)
8. run `vagrant package --base "$basebox" --output "${basebox}.box"`

(1) you might want to change the time zone from USA/Chicago too<br>
(2) the defaults use my Github username, and the file paths are for Mac OS X<br>
(3) the Vagrant docs suggest this amount, but RHEL won't start with it<br>

That's it!

The VM: modeled according to the Vagrant doc requirements, similar to a GUI-created one.

The Kickstart: doc-modeled again, although there are some contextual adjustments.
* The firewall is disabled (do you want one interfering on a Vagrant VM?)
* SELinux is disabled (you're welcome!)
* It uses LVM, so you can play with the partition if you want
* It uses the RHEL-style 'wheel' group instead of the Ubuntu-style 'admin' group
* The only packages added are those required to install the guest additions  
