#!/bin/bash -e
# Installs chef and soloist pre-reqs on a CentOS-5.x server
# Installs RVM and Ruby version specified in $RUBY_VERSION environment variable

# install epel
rpm -q epel-release-5-4.noarch || rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm

# install git
yum install -y git

# rvm prereqs
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libffi-devel openssl-devel

# install curl
yum install -y curl

# install rsync
yum install -y rsync

cd ~

bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

echo "gem: --no-ri --no-rdoc" >> /etc/gemrc

cat <<'RVMRC_CONTENTS' > /etc/rvmrc
#rvm_install_on_use_flag=1
#rvm_trust_rvmrcs_flag=1
#rvm_gemset_create_on_use_flag=1
RVMRC_CONTENTS

. ~/.bashrc

rvm install ${RUBY_VERSION:-1.9.2}
