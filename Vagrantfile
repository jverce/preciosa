# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "preciosa-base-v0.1"
  config.vm.box_url = "http://lab.nqnwebs.com/preciosa-base-v0.1.box"
  config.vm.network :forwarded_port, guest: 8000, host: 8000
  config.vm.synced_folder ".", "/home/vagrant/preciosa" 

  config.vm.provision :shell, :path => "etc/install.sh", :args => "preciosa" 
end

