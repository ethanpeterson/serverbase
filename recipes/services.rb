#
# Cookbook:: serverbase
# Recipe:: services
# Description:: creates the nodejs service daemon
# Copyright:: 2018 All Rights Reserved.

# get AWS OpsWorks databag
app = search(:aws_opsworks_app).first

# define nginx service
service 'nginx' do
  action :nothing
end

# build service file path
template_name = ::File.join(node['serverbase']['nodeserver']['service_path'], node['serverbase']['nodeserver']['service_name'])
template_source = node['serverbase']['nodeserver']['service_name']
root_path = "#{node['serverbase']['nodeserver']['web_root']}/#{node['serverbase']['web']['site_name']}"

# systemd (init.d) service configuration for nodeJS app
template template_name do
  source "#{template_source}.erb"
  variables(
      node_env: app['environment']['NODE_ENV'], 
      node_path: node['serverbase']['nodeserver']['node_path'] % { version: node['serverbase']['nodeserver']['version'] },
      root_path: root_path
  )
  mode 755
end

# restart the nginx service
service "#{template_source}" do
  action [ :enable, :start ]
  notifies :restart, 'service[nginx]', :delayed
end

## Reload systemctl for RHEL 7+ after modifying the init file.
## execute 'node-daemon-reload' do
##     command "systemctl daemon-reload"
##     action :nothing
##     notifies :run, 'execute[node-daemon-enable]'
## end

## execute 'node-daemon-enable' do
##     command "systemctl enable #{template_source}"
##     #action :enable
##     notifies :run, 'execute[node-daemon-start]'
## end

## execute 'node-daemon-start' do
##     command "systemctl start #{template_source}"
##     action :nothing
## end

# Chef::Log.info("creating new file #{template_name}")

# disabled this as on new instances it gets called prematurely; for now we'll reload on deploy
## Reload init.d for CentOS 6/Amazon OS after modifying the init file.
# service "#{template_source}" do
#   service_name "#{template_source}"
#   subscribes :reload, "file[#{template_name}]"
#   action :restart
# end

## execute "#{template_source} reload" do
##   subscribes :reload, "file[#{template_name}]", :immediately
##   notifies :stop, "service[#{template_source}]", :immediately
##   notifies :run, "execute[#{template_source} restart]"
## end

## execute "#{template_source} restart" do
##   notifies :stop, "service[#{template_source}]", :immediately  
##   notifies :start, "service[#{template_source}]"
## end

