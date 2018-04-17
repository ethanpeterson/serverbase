#
# Cookbook:: serverbase
# Recipe:: shutdown
#
# Copyright:: 2017, The Authors, All Rights Reserved.

service node['serverbase']['nodeserver']['service_name'] do
    action :stop
end

root_path = "#{node['serverbase']['nodeserver']['web_root']}/#{node['serverbase']['web']['site_name']}"

directory root_path do
    recursive true
    action :delete
    only_if { ::Dir.exist?(root_path) }
end