#!/bin/bash


function check_root_password {
if [ `id -u` != 0 ]; then
        read -p "you must run this script as root. Please re run the script prefixed by sudo or log as root "
	exit
        if [ `uname -m` != i686 ]; then
                printf "By using this script on an x68_64 architecture\nYou will install 32bits libraries\nwhich is does'nt cause any problem but is not optimized\n"

        fi
fi
}
check_root_password
apt-get update
apt-get install -y  curl software-properties-common
apt-get install -y    linux-image-extra-$(uname -r)     linux-image-extra-virtual
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
apt-get update
apt-get install -y docker-ce
apt-cache madison docker-ce
#sudo docker run hello-world
systemctl enable docker
#update-rc.d docker defaults
docker --version
if  [[ $? != 0 ]] ;then echo "docker is not install...exiting";exit 1; fi
#systemctl status docker
#service docker status
