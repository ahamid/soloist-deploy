#
# Cookbook Name:: soloist-cron
# Recipe:: default
#

REMOTE_COOKBOOK_DIR='/var/chef-solo'
SOLO_CMD="rvm exec soloist"

file "/etc/cron.d/chef-solo" do
  content "5 * * * * root cd #{REMOTE_COOKBOOK_DIR}; #{SOLO_CMD}"
  mode "0644"
end
