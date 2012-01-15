# Simple Capfile to bootstrap a single machine and run soloist
#
# Usage: cap [bootstrap|deploy|sync|soloist] HOSTS=<hostname>[:<port>]
#
# Everything is done as root and designed to target a single server.

# RVM Capistrano integration to run commands under RVM ruby context
require "rvm/capistrano"

set :bootstrap_os, 'centos'               # determines what bootstrap script we run
set :rvm_ruby_string, '1.9.2'             # set to the RVM Ruby version to use on server
set :rvm_type, :system                    # install/use system RVM install
set :user, "root"                         # do everything as root
set :use_sudo, false                      # ...so we don't need sudo
set :local_chef_dir, "./chef"             # where your top level chef dir is relative to the Capfile
set :remote_chef_dir, "/var/chef-solo"    # where to upload chef cookbooks on the server
default_run_options[:pty] = true          # cargo culting this param...

on :start do
  # do some trivial parsing so we can use rsync instead of scp
  HOST=ENV['HOSTS'].split(':')[0]
  PORT=ENV['HOSTS'].split(':', -2)[1] || 22
end

def with_shell(shell)
  prev_shell = default_shell
  set :default_shell, shell
  yield
  set :default_shell, prev_shell
end

desc "Syncs cookbooks and runs soloist"
task :deploy do
  sync
  soloist
end

desc "Bootstrap server"
task :bootstrap do |server|
  with_shell "/bin/bash" do
    upload "bootstrap-#{bootstrap_os}.sh", "/root/bootstrap.sh"
    run "chmod a+x /root/bootstrap.sh"
    run "RUBY_VERSION=#{rvm_ruby_string} /root/bootstrap.sh"
  end
  install_base_gems
end

desc "Install gems that are needed for a chef run"
task :install_base_gems do
  run "gem list | grep soloist || gem install soloist --no-rdoc --no-ri"
end

desc "Rsyncs cookbooks to server"
task :sync do
  run "mkdir -p #{remote_chef_dir}"
  run "mkdir -m 0775 -p #{remote_chef_dir}"
  # trailing slash on source to copy contents
  puts `rsync -avz -e "ssh -p#{PORT}" "#{local_chef_dir}/" "root@#{HOST}:#{remote_chef_dir}" --exclude ".svn" --exclude ".git"`
end

desc "Runs soloist"
task :soloist do
  run "cd #{remote_chef_dir} && PATH=/usr/sbin:$PATH LOG_LEVEL=debug soloist"
end
