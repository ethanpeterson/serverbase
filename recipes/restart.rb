#
# Cookbook:: serverbase
# Recipe:: restart
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

# restart nginx service
service 'nginx' do
  action :restart
  notifies :restart, "service[#{node['serverbase']['nodeserver']['service_name']}]"
end

# define this service so we can reference it
service node['serverbase']['nodeserver']['service_name'] do
  action :nothing
end
