#
# Cookbook:: serverbase
# Recipe:: structure
# Description:: creates the basic directory structure for the nginx & node.js services
# Copyright:: 2018 All Rights Reserved.

root_path = "#{node['serverbase']['nodeserver']['web_root']}/#{node['serverbase']['web']['site_name']}"

# Create the nodejs root directory.
directory root_path do
  action :create    #default
  recursive true
  group node['nginx']['group']
end

# Create a path to the nodejs startup script
javascript_script_path = ::File.join(root_path, node['serverbase']['nodeserver']['starter_script'])

# Write the nodejs startup script to the filesystem.
cookbook_file javascript_script_path do
  source node['serverbase']['nodeserver']['starter_script']
  user node['nginx']['user']
  group node['nginx']['group']
end