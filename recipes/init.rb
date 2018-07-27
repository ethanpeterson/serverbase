#
# Cookbook:: serverbase
# Recipe:: init
#
# Copyright:: 2017, The Authors, All Rights Reserved.

swap_file '/mnt/swap' do
    size node['serverbase']['swap']['size']    # MBs
end

# keep ubuntu up to date
apt_update 'daily' do
    frequency 86_400
    action :periodic
end
  
execute 'yum_update' do
    command 'yum update -y -x mongodb\* -x nginx\*'
end