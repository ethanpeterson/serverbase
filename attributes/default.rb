
default['serverbase']['env'] = 'production'

default['chef']['opsworks']['user'] = 'ec2-user'

default['serverbase']['swap']['size'] = 1024

# nginx settings
default['serverbase']['web']['version'] = '1.16.1' # OVERRIDE ME
default['serverbase']['web']['source']['checksum'] = 'F11C2A6DD1D3515736F0324857957DB2DE98BE862461B5A542A3AC6188DBE32B' # OVERRIDE ME
default['serverbase']['web']['site_name'] = '<your site name>' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['domain'] = '<your fully qualified domain name>' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['csp'] = "default-src 'self' 'unsafe-inline'; img-src http: https: data:; script-src 'self' 'unsafe-inline' http: https: data: google-analytics.com " \
"google.com; style-src 'self' 'unsafe-inline' https:; frame-src https: 'unsafe-inline' stitchz.net"
default['serverbase']['web']['maxbodysize'] = '10m'
# default['serverbase']['web']['yourfullyqualifieddomainname'] = 'localhost'
# default['serverbase']['web']['yourdomain'] = 'localhost'
# default['serverbase']['web']['nginxlogpath'] = "/var/log/nginx/#{['serverbase']['web']['site_name']}.log"
default['serverbase']['web']['ssl_cert_path'] = '/etc/ssl/<cert name>.crt' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['ssl_cert_key_path'] = '/etc/ssl/<cert key file name>.key' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['ssl_CA_path'] = '/etc/ssl/<certificate authority cert name>.crt' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['ssl_combined_cert_path'] = '/etc/ssl/<site cert combined with CA cert file name>.crt' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['ssl_cert_trust_chain'] = '<root CA cert file name>.crt' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['ssl_cert_trust_chain_path'] = '/etc/ssl/<root CA cert file name>.crt' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['ssl_dhparam_path'] = '/etc/ssl/dhparam.pem' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['ssl_dhparam'] = '-----BEGIN DH PARAMETERS-----
<... generated by running "openssl dhparam -out dhparam4096.pem 4096" ...>
-----END DH PARAMETERS-----' # OVERRIDE ME (REQUIRED)
default['serverbase']['web']['user'] = 'www-data' # OVERRIDE ME
default['serverbase']['web']['group'] = 'www-data' # OVERRIDE ME

# nodeJS settings
default['serverbase']['nodeserver']['version'] = '12.13.0' # OVERRIDE ME
default['serverbase']['nodeserver']['binary']['checksum'] = 'c69671c89d0faa47b64bd5f37079e4480852857a9a9366ee86cdd8bc9670074a' # OVERRIDE ME
default['serverbase']['nodeserver']['service_name'] = '<your site service name>' # OVERRIDE ME (REQUIRED)
default['serverbase']['nodeserver']['node_domain'] = '127.0.0.1:3000'
default['serverbase']['nodeserver']['url'] = 'http://127.0.0.1:3000'
default['serverbase']['nodeserver']['web_root'] = '/srv/www'
# default['serverbase']['nodeserver']['log_path'] = "#{node['serverbase']['nodeserver']['web_root']}/#{node['serverbase']['web']['site_name']}/logs/"
default['serverbase']['nodeserver']['temp_path'] = 'temp' # i.e. '/srv/www/temp'
default['serverbase']['nodeserver']['starter_script'] = 'server.js' # OR 'app.js'
default['serverbase']['nodeserver']['service_path'] = '/etc/rc.d/init.d/' # OR '/etc/systemd/system/'
default['serverbase']['nodeserver']['node_path'] = '/usr/local/src/nvm/versions/node/v%{version}/bin'

# mongoDb settings
default['serverbase']['mongoserver']['version'] = '3.6.7' # OVERRIDE ME
default['serverbase']['mongoserver']['instance_name'] = '<what ever you want to call your mongodb instance>' # OVERRIDE ME (REQUIRED)
default['serverbase']['mongoserver']['account_name'] = '<account name>' # OVERRIDE ME (REQUIRED)
default['serverbase']['mongoserver']['primary_database'] = 'admin'
default['serverbase']['mongoserver']['secondary_database'] = node['serverbase']['web']['site_name'] # OVERRIDE ME (REQUIRED)
default['serverbase']['mongoserver']['admin_name'] = 'admin'

###### OVERWRITE DEPENDENT ATTRIBUTES #####

# nginx settings
node.override['nginx']['install_method'] = 'source' # allows us to specify nginx version
node.override['nginx']['version'] = node['serverbase']['web']['version']
node.override['nginx']['source']['checksum'] = node['serverbase']['web']['source']['checksum']
node.override['nginx']['source']['version'] = node['nginx']['version']
node.override['nginx']['source']['prefix']  = "/opt/nginx-#{node['nginx']['version']}"
node.override['nginx']['source']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['version']}.tar.gz"
default['nginx']['user'] = node['serverbase']['web']['user']
default['nginx']['group'] = node['serverbase']['web']['group']
default['nginx']['client_max_body_size'] = '2M' # https://www.cyberciti.biz/faq/linux-unix-bsd-nginx-413-request-entity-too-large/

# nodejs settings
node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['version'] = node['serverbase']['nodeserver']['version'] # '8.9.4' # https://nodejs.org/dist/  OR https://nodejs.org/dist/v9.8.0/
node.default['nodejs']['binary']['checksum'] = node['serverbase']['nodeserver']['binary']['checksum']
# ^-- '21fb4690e349f82d708ae766def01d7fec1b085ce1f5ab30d9bda8ee126ca8fc' for node-v9.8.0-linux-x64.tar.gz

# mongodb configuration
node.default['mongodb']['package_version'] = node['serverbase']['mongoserver']['version'] # 'version-release' # OVERRIDE ME
# default['mongodb']['config']['mongod']['systemLog']['path'] = '/var/lib/mongodb/log/mongodb.log'
# default['mongodb']['config']['mongod']['systemLog']['verbosity'] = '0'
# default['mongodb']['config']['mongod']['systemLog']['destination'] = 'file'
# default['mongodb']['config']['mongod']['systemLog']['logAppend'] = 'true'
# default['mongodb']['config']['mongod']['storage']['dbPath'] = '/var/lib/mongodb/data/db'
# default['mongodb']['config']['mongod']['storage']['directoryPerDB'] = 'true'
# default['mongodb']['config']['mongod']['journal']['enabled'] = 'true'
default['mongodb']['config']['auth'] = true
# default['mongodb']['mongos_create_admin'] = false  #mongos (sharding only)
default['mongodb']['config']['mongod']['security']['authorization'] = 'enabled'
