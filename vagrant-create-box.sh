groupadd vagrant
useradd -G vagrant vagrant
passwd vagrant

sudo visudo -f /etc/sudoers.d/vagrant
vagrant ALL=(ALL) NOPASSWD:ALL
Defaults:vagrant !requiretty
Defaults env_keep="SSH_AUTH_SOCK"

sudo yum update -y
sudo shutdown -r now
mkdir -p /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

sudo yum install -y openssh-server
sudo chkconfig sshd on
sudo vi /etc/ssh/sshd_config
AuthorizedKeysFile %h/.ssh/authorized_keys
sudo service sshd restart

sudo yum install -y gcc make kernel-devel
#yum install kernel-devel-2.6.32-504.el6.x86_64
mkdir /media/VBOXADDITIONS
mount /dev/cdrom /media/VBOXADDITIONS
cd /media/VBOXADDITIONS
sudo ./VBoxLinuxAdditions.run
sudo umount /media/VBOXADDITIONS
cd ~
lsmod | grep vboxsf
sudo /etc/init.d/vboxadd setup

sudo yum clean all
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sudo shutdown -h now

mkdir ~/code/personal/vagrant_boxes
cd ~/code/personal/vagrant_boxes
#vagrant package --base vm-name
# para crear archivo Vagrantfile
vagrant init 
vagrant package --output vm-name.box --base vm-name --vagrantfile Vagrantfile
#test
vagrant box add ubuntu64 package.box
vagrant init ubuntu64
vagrant up
vagrant ssh

#UBUNTU
sudo apt-get install sysv-rc-conf
sysv-rc-conf ssh on

sudo apt-get install build-essential module-assistant
sudo m-a prepare

sudo ./VBoxLinuxAdditions.run 
lsmod | grep -io vboxguest
modinfo vboxguest
