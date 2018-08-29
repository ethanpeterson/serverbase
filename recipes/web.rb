#
# Cookbook:: serverbase
# Recipe:: web
# Description:: sets up the nginx server/service
# Copyright:: 2018 All Rights Reserved.

# reference the nginx recipe
include_recipe 'nginx'

# disable the default site
nginx_site 'default' do
  action :disable
end

temp_path = "#{node['serverbase']['nodeserver']['web_root']}/#{node['serverbase']['nodeserver']['temp_path']}"

# Install nginx and start the service.
nginx_site node['serverbase']['web']['site_name'] do
  template 'site.conf.erb'
  variables(
    temp_path: temp_path,
    ssl_cert_path: node[:serverbase][:web][:ssl_combined_cert_path],
    ssl_cert_key_path: node[:serverbase][:web][:ssl_cert_key_path],
    ssl_dhparam: node[:serverbase][:web][:ssl_dhparam_path],
    ssl_cert_trust_chain_path: node[:serverbase][:web][:ssl_cert_trust_chain_path]
  )
  name node['serverbase']['web']['site_name']
  action :enable
  notifies :restart, 'service[nginx]'
end

# start nginx service
service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
