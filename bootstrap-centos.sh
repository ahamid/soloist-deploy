#!/bin/bash
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

# grab updated curl cacert
# this is hosted on http, so yeah, if this is hacked game over
# take your chances
curl http://curl.haxx.se/ca/cacert.pem -o ~/curl-cacert.pem
export CURL_CA_BUNDLE=~/curl-cacert.pem
bash -s stable < <(curl -# -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
export CURL_CA_BUNDLE=

echo "gem: --no-ri --no-rdoc" >> /etc/gemrc

cat <<'RVMRC_CONTENTS' > /etc/rvmrc
#rvm_install_on_use_flag=1
#rvm_trust_rvmrcs_flag=1
#rvm_gemset_create_on_use_flag=1
RVMRC_CONTENTS

. ~/.bashrc

INSTALL_RUBY=${RUBY_VERSION:-1.9.2}
echo "installing ruby ${INSTALL_RUBY}"
rvm install "${INSTALL_RUBY}"
