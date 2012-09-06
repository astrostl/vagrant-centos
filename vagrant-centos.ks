install
text
cdrom
lang en_US.UTF-8
keyboard us
network --onboot yes --device eth0 --bootproto dhcp --noipv6 --hostname vagrant-centos-6-3.vagrantup.com
rootpw vagrant
firewall --disabled
authconfig --enableshadow --passalgo=sha512
selinux --disabled
timezone --utc America/Chicago
zerombr
clearpart --all
part /boot --fstype=ext4 --size=512
part pv.01 --grow --size=1
volgroup vg_vagrantcentos63 --pesize=4096 pv.01
logvol swap --name=lv_swap --vgname=vg_vagrantcentos63 --size=1024
logvol / --fstype=ext4 --name=lv_root --vgname=vg_vagrantcentos63 --grow --size=1
bootloader --location=mbr --append="crashkernel=auto rhgb quiet"
user --name=vagrant --groups=wheel --password=vagrant
poweroff --eject

%packages --nobase
@core
%end

%post --nochroot
cp /etc/resolv.conf /mnt/sysimage/etc/resolv.conf
%end

%post
/usr/bin/yum -y install sudo gcc "kernel-devel-$(uname -r)" make perl rubygems ruby-devel
/bin/cat << EOF > /etc/sudoers.d/wheel
Defaults:%wheel env_keep += "SSH_AUTH_SOCK"
Defaults:%wheel !requiretty
%wheel ALL=NOPASSWD: ALL
EOF
/bin/chmod 0440 /etc/sudoers.d/wheel
/bin/mkdir /mnt/vbox
/bin/mount -t iso9660 /dev/sr1 /mnt/vbox
/mnt/vbox/VBoxLinuxAdditions.run
/bin/umount /mnt/vbox
/bin/rmdir /mnt/vbox
/usr/bin/gem install --no-ri --no-rdoc puppet
/usr/sbin/groupadd -r puppet
/usr/bin/gem install --no-ri --no-rdoc chef
/bin/mkdir /home/vagrant/.ssh
/bin/chmod 700 /home/vagrant/.ssh
/usr/bin/curl -o /home/vagrant/.ssh/id_rsa https://raw.github.com/mitchellh/vagrant/master/keys/vagrant
/usr/bin/curl -o /home/vagrant/.ssh/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
/bin/chown -R vagrant:vagrant /home/vagrant/.ssh
/bin/chmod 0400 /home/vagrant/.ssh/*
/bin/echo 'UseDNS no' >> /etc/ssh/sshd_config
/usr/bin/yum -y clean all
/sbin/swapoff -a
/sbin/mkswap /dev/mapper/vg_vagrantcentos63-lv_swap
/bin/dd if=/dev/zero of=/boot/EMPTY bs=1M
/bin/rm -f /boot/EMPTY
/bin/dd if=/dev/zero of=/EMPTY bs=1M
/bin/rm -f /EMPTY
%end
