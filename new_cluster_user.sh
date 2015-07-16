#!/bin/bash
if [[ $# -ne 1 ]] ; then
    echo 'Usage: new_cluster_user <user name>'
    exit 0
fi

eval echo 'Adding user $1'
useradd $1
eval echo 'Updating NIS database'
cd /var/yp
make
eval echo eval 'Creating /sharedscratch/$1'
mkdir -p /sharedscratch/$1
chown $1:$1 /sharedscratch/$1
eval echo eval 'Creating /sharedluste/$1'
mkdir -p /sharedlustre/$1
chown $1:$1 /sharedlustre/$1
eval echo 'Creating rsa keys'
mkdir -p /home/$1/.ssh
chown $1:$1 /home/$1/.ssh
chmod 700 /home/$1/.ssh
cd /home/$1/.ssh
ssh-keygen -f id_rsa -t rsa  -N ""
cp id_rsa.pub authorized_keys
chown $1:$1 id_rsa id_rsa.pub authorized_keys
exit 






