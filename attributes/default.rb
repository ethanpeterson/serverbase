
default['doorsinfo']['env'] = 'production'
default['doorsinfo']['node_version'] = '10.3.0'

default['doorsinfo']['scm']['package_name'] = 'doorsinfo.zip'
default['doorsinfo']['scm']['bucket'] = 'doorsinfo-source-files'

default['doorsinfo']['web']['site_name'] = 'doorsinfo'

default['doorsinfo']['nodeserver']['web_root'] = '/srv/www'
default['doorsinfo']['nodeserver']['node_path'] = "/usr/local/src/nvm/versions/node/v%{version}/bin"
default['doorsinfo']['nodeserver']['npm_packages'] = {
  'webpack'  => '3.11.0',
  'babel'     => '6.23.0'
} # defines npm packages to install globally

###### OVERWRITE DEPENDENT ATTRIBUTES #####

# nginx settings
default.override['nginx']['group'] = 'www-data'

# mongodb settings
default.override['mongodb']['package_version'] = '3.6.3'

# serverbase settings
default.override['serverbase']['node_version'] = '10.3.0'
default.override['serverbase']['node_checksum'] = 'b9565d47f5cb95c9d01133b4266a3717f0ee7d3ccaff6d53275462eab40413f2'
default.override['serverbase']['web']['site_name'] = 'doorsinfo'
default.override['serverbase']['web']['domain'] = 'doorsinfo.com'
default.override['serverbase']['web']['ssl_cert_path'] = '/etc/ssl/www_doorsinfo_com.crt'
default.override['serverbase']['web']['ssl_cert_key_path'] = '/etc/ssl/doorsinfo.com.key'
default.override['serverbase']['web']['ssl_CA_path'] = '/etc/ssl/COMODO_RSA_Certification_Authority.crt'
default.override['serverbase']['web']['ssl_combined_cert_path'] = '/etc/ssl/doorsinfo_CA_combined.crt'
default.override['serverbase']['nodeserver']['service_name'] = "doorsinfod"
default.override['serverbase']['mongoserver']['instance_name'] = "doorsinfo-mongodb"
default.override['serverbase']['mongoserver']['account_name'] = 'doorsadm1n'
