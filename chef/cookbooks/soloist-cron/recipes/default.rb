#
# Cookbook Name:: soloist-cron
# Recipe:: default
#

REMOTE_COOKBOOK_DIR='/var/chef-solo'
SOLO_CMD="rvm 1.9.2 exec soloist 2>&1 | logger -t soloist -p notice"

cron "chef-solo" do
  minute "5"
  command "cd #{REMOTE_COOKBOOK_DIR}; #{SOLO_CMD}"
end
