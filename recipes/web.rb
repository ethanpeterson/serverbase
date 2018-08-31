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

# ruby_block 'set-nginx-path' do
#   block do
#     ENV['PATH'] = "#{ENV['PATH']}:/opt/nginx-1.12.1/sbin/nginx"
#   end
#   not_if 'env | grep nginx'
# end

Chef::Log.info("************************************************************")
Chef::Log.info("Setting NGINX PATH VARIABLES...")

# OS level PATH environment variables
# this is needed (for some reason), but not required, on Amazon Linux 2018.03 builds with NGINX 1.14.0+
# the DIRECTORY path may change in future releases or based on how the NGINX recipe is run
file '/etc/profile.d/nginx.sh' do
  content <<-EOF
#!/bin/bash

DIRECTORY="/opt/nginx-1.12.1/sbin"
  
if [ -d "$DIRECTORY" ]; then
  if [ ! $(env | grep nginx) ]; then
    export PATH=$PATH:$DIRECTORY
  fi
fi  
  EOF
  not_if { ::File.exists?('/etc/profile.d/nginx.sh')}
end

Chef::Log.info("************************************************************")