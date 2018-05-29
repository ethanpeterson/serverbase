#
# Cookbook:: serverbase
# Recipe:: ssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

Chef::Log.info("************************************************************")

# get AWS OpsWorks databag
app = search(:aws_opsworks_app).first

file node['serverbase']['web']['ssl_cert_path'] do
    content app['ssl_configuration']['certificate']
    owner 'root'
    group node['nginx']['group']
    mode 0740
    only_if { ! app['ssl_configuration']['certificate'].nil? }  # only if the AWS SSL Settings are populated
    not_if { ::File.exist?(node['serverbase']['web']['ssl_cert_path']) } # don't run this resource if the cert already exists in the directory
end

file node['serverbase']['web']['ssl_cert_key_path'] do
    content app['ssl_configuration']['private_key']
    owner 'root'
    group node['nginx']['group']
    mode 0740
    only_if { ! app['ssl_configuration']['private_key'].nil? }  # only if the AWS SSL Settings are populated
    not_if { ::File.exist?(node['serverbase']['web']['ssl_cert_key_path']) } # don't run this resource if the cert already exists in the directory
end

file node['serverbase']['web']['ssl_CA_path'] do
    content app['ssl_configuration']['chain']
    owner 'root'
    group node['nginx']['group']
    mode 0740
    only_if { ! app['ssl_configuration']['chain'].nil? }  # only if the AWS SSL Settings are populated
    not_if { ::File.exist?(node['serverbase']['web']['ssl_CA_path']) } # don't run this resource if the cert already exists in the directory
end

execute "concat_certs" do
    cwd "/etc/ssl/"
    command "cat #{node['serverbase']['web']['ssl_cert_path']} #{node['serverbase']['web']['ssl_CA_path']} > #{node['serverbase']['web']['ssl_combined_cert_path']}"
    only_if { ::File.exist?(node['serverbase']['web']['ssl_CA_path']) }  # only if the CA cert exists
    not_if { ::File.exist?(node['serverbase']['web']['ssl_combined_cert_path']) }
end

Chef::Log.info("************************************************************")
