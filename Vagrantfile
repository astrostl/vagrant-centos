# put this file in ~/.vagrant.d
# make a ~/.vagrant.d/manifests directory with a 'default.pp' Puppet manifest

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "~/.vagrant.d/manifests"
  end
end
