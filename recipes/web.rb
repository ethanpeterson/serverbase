#
# Cookbook:: serverbase
# Recipe:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.

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
    temp_path: temp_path
  )
  name node['serverbase']['web']['site_name']
  action :enable
  notifies :restart, 'service[nginx]'
end

# add the necessary users to the nginx group
group "nginx" do
  action :modify
  append true
  members [ node['chef']['opsworks']['user'] ]
end

# start nginx service
service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
