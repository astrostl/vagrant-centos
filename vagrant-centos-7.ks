text
cdrom
lang en_US.UTF-8
keyboard --vckeymap=us --xlayouts='us'
network  --bootproto=dhcp --device=enp0s3 --noipv6 --activate
network  --hostname=vagrant-centos-7.vagrantup.com
rootpw vagrant
firewall --disabled
auth --enableshadow --passalgo=sha512
selinux --disabled
timezone America/Chicago --isUtc --nontp
ignoredisk --only-use=sda
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
autopart --type=lvm
clearpart --none --initlabel
user --name=vagrant --groups=wheel --password=vagrant
firstboot --enable
services --disabled="chronyd"
poweroff --eject

%packages
@^minimal
@core
kexec-tools
%end

%addon com_redhat_kdump --enable --reserve-mb='auto'
%end

%post --nochroot
cp /etc/resolv.conf /mnt/sysimage/etc/resolv.conf
%end

%post
/usr/bin/yum -y install sudo gcc "kernel-devel-$(uname -r)" make perl bzip2
/bin/cat << EOF > /etc/sudoers.d/wheel
Defaults:%wheel env_keep += "SSH_AUTH_SOCK"
Defaults:%wheel !requiretty
%wheel ALL=(ALL) NOPASSWD: ALL
EOF
/bin/chmod 0440 /etc/sudoers.d/wheel
/bin/mkdir /mnt/vbox
/bin/mount -t iso9660 /dev/sr1 /mnt/vbox
/mnt/vbox/VBoxLinuxAdditions.run
/bin/umount /mnt/vbox
/bin/rmdir /mnt/vbox
/bin/rpm -i https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
/usr/bin/yum -y install puppet-agent
/bin/rpm -i https://opscode-omnibus-packages.s3.amazonaws.com/el/7/x86_64/chef-12.6.0-1.el7.x86_64.rpm
/bin/rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
/usr/bin/yum -y install ansible
/bin/rpm -e epel-release
/bin/mkdir /home/vagrant/.ssh
/bin/chmod 700 /home/vagrant/.ssh
/usr/bin/curl -L -o /home/vagrant/.ssh/id_rsa https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant
/usr/bin/curl -L -o /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
/bin/chown -R vagrant:vagrant /home/vagrant/.ssh
/bin/chmod 0600 /home/vagrant/.ssh/*
/bin/echo 'UseDNS no' >> /etc/ssh/sshd_config
/bin/echo '127.0.0.1   vagrant-centos-7.vagrantup.com' >> /etc/hosts
/usr/bin/yum -y clean all
/sbin/swapoff -a
/sbin/mkswap /dev/mapper/centos_vagrant--centos--7-swap
/bin/dd if=/dev/zero of=/boot/EMPTY bs=1M
/bin/rm -f /boot/EMPTY
/bin/dd if=/dev/zero of=/EMPTY bs=1M
/bin/rm -f /EMPTY
/bin/sync
%end