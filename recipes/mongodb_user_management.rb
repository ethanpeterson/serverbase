#
# Cookbook:: serverbase
# Recipe:: mongodb_user_management
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

# get AWS OpsWorks databag
app = search(:aws_opsworks_app).first

# begin setting up user authentication
node.override['mongodb']['admin']['username'] = node['serverbase']['mongoserver']['admin_name']
node.override['mongodb']['admin']['password'] = app['environment']['MONGODB_ADMIN_PASSWORD']
node.override['mongodb']['authentication']['username'] = node['serverbase']['mongoserver']['admin_name']
node.override['mongodb']['authentication']['password'] = app['environment']['MONGODB_ADMIN_PASSWORD']
node.override['mongodb']['users'] = [
  {
    'username' => node['serverbase']['mongoserver']['admin_name'],
    'password' => app['environment']['MONGODB_ADMIN_PASSWORD'],
    'roles' => %w[dbOwner root userAdminAnyDatabase dbAdminAnyDatabase],
    'database' => node['serverbase']['mongoserver']['primary_database'],
    'passwordDigestor' => 'server'
  },
  {
    'username' => node['serverbase']['mongoserver']['admin_name'],
    'password' => app['environment']['MONGODB_ADMIN_PASSWORD'],
    'roles' => %w[read userAdmin],
    'database' => node['serverbase']['mongoserver']['secondary_database'],
    'passwordDigestor' => 'server'
  },
  {
    'username' => node['serverbase']['mongoserver']['account_name'],
    'password' => app['environment']['APP_ADMIN_PASSWORD'],
    'roles' => %w[dbAdmin readWrite],
    'database' => node['serverbase']['mongoserver']['secondary_database'],
    'passwordDigestor' => 'server'
  }
]

# call the mongodb user creation scripts
include_recipe 'sc-mongodb::user_management'
