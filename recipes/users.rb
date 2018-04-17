#
# Cookbook:: serverbase
# Recipe:: users
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# create the nginx unix group
group node[:nginx][:group] do
    action :create
    append true
    members [ node['chef']['opsworks']['user'] ]
end

# create the nginx user
user node[:nginx][:user] do
    home  "/home/#{node[:nginx][:user]}"
    shell '/bin/bash'
    uid 4002    # can be any number as long as it's unique
    gid node[:nginx][:group]
    action :create
end
