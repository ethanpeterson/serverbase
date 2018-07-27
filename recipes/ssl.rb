#
# Cookbook:: serverbase
# Recipe:: ssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

Chef::Log.info("************************************************************")

# get AWS OpsWorks databag
app = search(:aws_opsworks_app).first

# local path to website cert - content should be stored in AWS's app ssl settings
file node['serverbase']['web']['ssl_cert_path'] do
    content app['ssl_configuration']['certificate']
    owner 'root'
    group node['nginx']['group']
    mode 0740
    only_if { ! app['ssl_configuration']['certificate'].nil? }  # only if the AWS SSL Settings are populated
    #not_if { ::File.exist?(node['serverbase']['web']['ssl_cert_path']) } # don't run this resource if the cert already exists in the directory
end

# local path to certificate key - content should be stored in AWS's app ssl settings
file node['serverbase']['web']['ssl_cert_key_path'] do
    content app['ssl_configuration']['private_key']
    owner 'root'
    group node['nginx']['group']
    mode 0740
    only_if { ! app['ssl_configuration']['private_key'].nil? }  # only if the AWS SSL Settings are populated
    #not_if { ::File.exist?(node['serverbase']['web']['ssl_cert_key_path']) } # don't run this resource if the cert already exists in the directory
end

# local path to certificate authority chain cert - content should be stored in AWS's app ssl settings
file node['serverbase']['web']['ssl_CA_path'] do
    content app['ssl_configuration']['chain']
    owner 'root'
    group node['nginx']['group']
    mode 0740
    only_if { ! app['ssl_configuration']['chain'].nil? }  # only if the AWS SSL Settings are populated
    #not_if { ::File.exist?(node['serverbase']['web']['ssl_CA_path']) } # don't run this resource if the cert already exists in the directory
end

# diffie-hellman key exchange parameters - enhances security by negotiating a secret
file node['serverbase']['web']['ssl_dhparam_path'] do
    content node[:serverbase][:web][:ssl_dhparam]
    owner 'root'
    group node['nginx']['group']
    mode 0740
    #only_if { ! app['environment']['DHPARAM'].nil? }  # only if the AWS SSL Settings are populated
    #not_if { ::File.exist?(node['serverbase']['web']['ssl_dhparam']) } # don't run this resource if the cert already exists in the directory
end

execute "concat_certs" do
    cwd "/etc/ssl/"
    command "bash -c 'cat #{node[:serverbase][:web][:ssl_cert_path]} <(echo) #{node[:serverbase][:web][:ssl_CA_path]} > #{node[:serverbase][:web][:ssl_combined_cert_path]}'"
    only_if { ::File.exist?(node['serverbase']['web']['ssl_CA_path']) }  # only if the CA cert exists
    #not_if { ::File.exist?(node['serverbase']['web']['ssl_combined_cert_path']) }
end

Chef::Log.info("************************************************************")
