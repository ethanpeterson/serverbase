#
# Cookbook:: serverbase
# Recipe:: dbserver
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

include_recipe 'sc-mongodb::default'

mongodb_instance node['serverbase']['mongoserver']['instance_name'] do
  # auth node['mongodb']['config']['auth']
end
