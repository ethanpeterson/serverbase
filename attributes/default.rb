
default['serverbase']['env'] = 'production'
default['serverbase']['node_version'] = '9.8.0' # OVERRIDE ME
default['serverbase']['node_checksum'] = '4e519de3507f810b6567d995169c4b36f433bf5731340ebc1fbbd0b6b6e6c310' # OVERRIDE ME

default['chef']['opsworks']['user'] = 'ec2-user'

default['serverbase']['swap']['size'] = 1024

default['serverbase']['web']['site_name'] = 'doorsinfo' # OVERRIDE ME
default['serverbase']['web']['domain'] = 'doorsinfo.com' # OVERRIDE ME
# default['serverbase']['web']['yourfullyqualifieddomainname'] = 'localhost'
# default['serverbase']['web']['yourdomain'] = 'localhost'
# default['serverbase']['web']['nginxlogpath'] = "/var/log/nginx/#{['serverbase']['web']['site_name']}.log"
default['serverbase']['web']['ssl_cert_path'] = '/etc/ssl/www_doorsinfo_com.crt' # OVERRIDE ME
default['serverbase']['web']['ssl_cert_key_path'] = '/etc/ssl/doorsinfo.com.key' # OVERRIDE ME
default['serverbase']['web']['ssl_CA_path'] = '/etc/ssl/AddTrust_External_CA_Root.crt' # OVERRIDE ME
default['serverbase']['web']['ssl_combined_cert_path'] = '/etc/ssl/doorsinfo_CA_combined.crt' # OVERRIDE ME

default['serverbase']['nodeserver']['node_domain'] = '127.0.0.1:3000'
default['serverbase']['nodeserver']['url'] = 'http://127.0.0.1:3000'
default['serverbase']['nodeserver']['web_root'] = '/srv/www'
# default['serverbase']['nodeserver']['log_path'] = "#{node['serverbase']['nodeserver']['web_root']}/#{node['serverbase']['web']['site_name']}/logs/"
default['serverbase']['nodeserver']['temp_path'] = "temp" # i.e. '/srv/www/temp'
default['serverbase']['nodeserver']['starter_script'] = 'server.js' # OR 'app.js'
default['serverbase']['nodeserver']['service_path'] = '/etc/init.d/' # OR '/etc/systemd/system/'
default['serverbase']['nodeserver']['service_name'] = "doorsinfod" # OR 'doorsinfo.service' # OVERRIDE ME
default['serverbase']['nodeserver']['node_path'] = "/usr/local/src/nvm/versions/node/v%{version}/bin/node"

default['serverbase']['mongoserver']['instance_name'] = "doorsinfo-mongodb" # OVERRIDE ME
default['serverbase']['mongoserver']['primary_database'] = 'admin'
default['serverbase']['mongoserver']['secondary_database'] = node['serverbase']['web']['site_name']
default['serverbase']['mongoserver']['admin_name'] = 'admin'
default['serverbase']['mongoserver']['account_name'] = 'doorsadm1n' # OVERRIDE ME


###### OVERWRITE DEPENDENT ATTRIBUTES #####

# nginx settings
default['nginx']['user'] = 'www-data'
default['nginx']['group'] = 'www-data'
default['nginx']['client_max_body_size'] = '2M'  # https://www.cyberciti.biz/faq/linux-unix-bsd-nginx-413-request-entity-too-large/

# nodejs settings
node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['version'] = node['serverbase']['node_version'] #'8.9.4' # https://nodejs.org/dist/  OR https://nodejs.org/dist/v9.8.0/
node.default['nodejs']['binary']['checksum'] = node['serverbase']['node_checksum'] #'21fb4690e349f82d708ae766def01d7fec1b085ce1f5ab30d9bda8ee126ca8fc'

# mongodb configuration
node.default['mongodb']['package_version'] = '3.6.3' #'version-release' # OVERRIDE ME
#default['mongodb']['config']['mongod']['systemLog']['path'] = '/var/lib/mongodb/log/mongodb.log'
#default['mongodb']['config']['mongod']['systemLog']['verbosity'] = '0'
#default['mongodb']['config']['mongod']['systemLog']['destination'] = 'file'
#default['mongodb']['config']['mongod']['systemLog']['logAppend'] = 'true'
#default['mongodb']['config']['mongod']['storage']['dbPath'] = '/var/lib/mongodb/data/db'
#default['mongodb']['config']['mongod']['storage']['directoryPerDB'] = 'true'
#default['mongodb']['config']['mongod']['journal']['enabled'] = 'true'
default['mongodb']['config']['auth'] = true
#default['mongodb']['mongos_create_admin'] = false  #mongos (sharding only)
default['mongodb']['config']['mongod']['security']['authorization'] = 'enabled'

