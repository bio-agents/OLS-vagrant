# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |ols|

  ols.vm.box = "ubuntu/trusty64"

  # Check what ports needed - 8983 for solr
  ols.vm.network "forwarded_port", guest: 8080, host: 8880
  ols.vm.network "forwarded_port", guest: 8983, host: 8983
  ols.vm.network "forwarded_port", guest:7474, host:7474

  # Check how much memory we need
  ols.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 4096]
  end
  ols.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  ols.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "vagrant.pp"
  end

end
