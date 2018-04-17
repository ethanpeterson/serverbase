#
# Cookbook:: serverbase
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#setup
include_recipe 'serverbase::init'
include_recipe 'serverbase::users'
include_recipe 'serverbase::structure'
include_recipe 'serverbase::web'
include_recipe 'serverbase::nodeserver'
include_recipe 'serverbase::dbserver'

#configure
include_recipe 'serverbase::mongodb_user_management'
include_recipe 'serverbase::services'

#shutdown
# include_recipe 'serverbase::shutdown'