#!/bin/bash
#
# Windows shell provisioner for Ansible playbooks, based on KSid's
# windows-vagrant-ansible: https://github.com/KSid/windows-vagrant-ansible
#
# @todo - Allow proxy configuration to be passed in via Vagrantfile config.
#
# @see README.md
# @author Jeff Geerling, 2014
# @version 1.0
#

# Uncomment if behind a proxy server.
# export {http,https,ftp}_proxy='http://username:password@proxy-host:80'

VAGRANT_PATH=/home/vagrant
ANSIBLE_PATH=$VAGRANT_PATH/.ansible

ANSIBLE_PLAYBOOK=$1
ANSIBLE_HOSTS=$2
TEMP_HOSTS=$VARGRANT_PATH/.ansible_hosts

if [ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]; then
  echo "Cannot find Ansible playbook."
  exit 1
fi

if [ ! -f /vagrant/$ANSIBLE_HOSTS ]; then
  echo "Cannot find Ansible hosts."
  exit 2
fi

# Install Ansible and its dependencies if it's not installed already.
if [ ! -f /usr/local/bin/ansible ]; then
  echo "Installing Ansible dependencies and Git."
  apt-get update && apt-get install python python-dev git-core vim-nox tmux -y
  # echo "Cloning ansible"
  # git clone https://github.com/ansible/ansible.git $ANSIBLE_PATH

  # echo "Copying the hosts file to ~"
  # cp /vagrant/${ANSIBLE_HOSTS} ${TEMP_HOSTS}
  # chown vagrant:vagrant ${TEMP_HOSTS}
  # chmod 622 ${TEMP_HOSTS}

  # echo "source $ANSIBLE_PATH/hacking/env-setup" >> $VAGRANT_PATH/.bashrc
  # echo "export ANSIBLE_HOSTS=$ANSIBLE_HOSTS" >> $VAGRANT_PATH/.bashrc
  echo "Installing pip via easy_install"
  wget http://peak.telecommunity.com/dist/ez_setup.py
  python ez_setup.py && rm -f ez_setup.py
  easy_install pip
  pip install setuptools --no-use-wheel --upgrade
  echo "Installing required python modules"
  pip install paramiko pyyaml jinja2 markupsafe
  echo "Installing Ansible"
  pip install ansible
fi

cp /vagrant/${ANSIBLE_HOSTS} ${TEMP_HOSTS} && chmod -x ${TEMP_HOSTS}
echo "Running Ansible provisioner defined in Vagrantfile"
ansible-playbook /vagrant/${ANSIBLE_PLAYBOOK} --inventory-file=${TEMP_HOSTS} --extra-vars "is_windows=true" --connection=local
