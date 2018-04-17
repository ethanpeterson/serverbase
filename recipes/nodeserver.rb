#
# Cookbook:: serverbase
# Recipe:: nodeserver
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# install nvm
include_recipe 'nvm'

# install node.js v9.8.0
nvm_install node['nodejs']['version']  do
  from_source false
  alias_as_default true
  group node['nginx']['group']
  action :create
end

