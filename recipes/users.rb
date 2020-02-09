#
# Cookbook:: serverbase
# Recipe:: users
# Description:: creates the OS level web server users
# Copyright:: 2018 All Rights Reserved.

# frozen_string_literal: true

# create the nginx unix group, i.e. 'www-data'
group node['nginx']['group'] do
  append true
  members [node['chef']['opsworks']['user']]
end

# add the necessary users to the nginx group
group 'nginx' do
  append true
  members [node['chef']['opsworks']['user']]
end

# create the nginx user
user node['nginx']['user'] do
  home  "/home/#{node['nginx']['user']}"
  shell '/bin/bash'
  uid 4002 # can be any number as long as it's unique
  gid node['nginx']['group']
  action :create
  not_if "getent passwd #{node['nginx']['user']}"
end
