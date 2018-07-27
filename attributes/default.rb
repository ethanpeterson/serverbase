
default['serverbase']['env'] = 'production'
default['serverbase']['node_version'] = '10.3.0' # OVERRIDE ME
default['serverbase']['node_checksum'] = 'b9565d47f5cb95c9d01133b4266a3717f0ee7d3ccaff6d53275462eab40413f2' # OVERRIDE ME

default['chef']['opsworks']['user'] = 'ec2-user'

default['serverbase']['swap']['size'] = 1024

default['serverbase']['web']['site_name'] = 'mywebsite' # OVERRIDE ME
default['serverbase']['web']['domain'] = 'mywebsite.com' # OVERRIDE ME
default['serverbase']['web']['csp'] = "default-src http: https: 'unsafe-inline' 'unsafe-eval'; img-src http: https: data:" #www.mywebsite.com mywebsite.com *.amazonaws.com *.cloudfront.net maxcdn.bootstrapcdn.com; script-src www.mywebsite.com mywebsite.com code.jquery.com cdnjs.cloudflare.com cdn.jsdelivr.net *.google-analytics.com; style-src www.mywebsite.com mywebsite.com maxcdn.bootstrapcdn.com' # OVERRIDE ME
# default['serverbase']['web']['yourfullyqualifieddomainname'] = 'localhost'
# default['serverbase']['web']['yourdomain'] = 'localhost'
# default['serverbase']['web']['nginxlogpath'] = "/var/log/nginx/#{['serverbase']['web']['site_name']}.log"
default['serverbase']['web']['ssl_cert_path'] = '/etc/ssl/www_mywebsite_com.crt' # OVERRIDE ME
default['serverbase']['web']['ssl_cert_key_path'] = '/etc/ssl/mywebsite.com.key' # OVERRIDE ME
default['serverbase']['web']['ssl_CA_path'] = '/etc/ssl/COMODO_RSA_Certification_Authority.crt' # OVERRIDE ME
default['serverbase']['web']['ssl_combined_cert_path'] = '/etc/ssl/mywebsite_CA_combined.crt' # OVERRIDE ME
default['serverbase']['web']['ssl_cert_trust_chain_path'] = '/etc/ssl/AddTrust_External_CA_Root.crt' # OVERRIDE ME
default['serverbase']['web']['ssl_dhparam_path'] = '/etc/ssl/dhparam.pem' # OVERRIDE ME
default['serverbase']['web']['ssl_dhparam'] = '-----BEGIN DH PARAMETERS-----
MIICCAKCAgEApCt14LJWXAQ/lVUv5rA5el72S0QVc5PRRYBzsxIsd43gRPEVpBTr
Du5ExzTKacJTH+9KGiweAHQ0PHgezYrgLIDIU1n1DttiqM5qzjOxbS7WvNP5SNZj
lSIN8cy7+RwzG6Gw/Lg8Ze42UC39tqoSUiH5IDdOqTyklxpZuoiPPIbgoa8FBeKV
9+CvYI0d1M0RsZwW3V21+qpUhBDUbDbDXPXrNDjJIYoz4rwAxr78avRBhO68gU89
YCkEGJmoVp8zAG9V+MRKSAfXpmXRyislCQzSPDXCYkoEfh+Sas0CGxG5CNgkNjhj
RFUK7gSzXiZriNAkPX4Sa7fBQtl50pDmsSw6pRHY+ctMJBWpvXTkGSVYzIc754u3
M32C5ErpOGHlnAP+c8d5RrKY9+QFsH7yhLlJBsZfbcfbyHvKHw3HjTEOHKWwnyGR
4rT/jqbhwt0poL9TbTz+cW1B3BQ+lIrWJczftagLEAnajsNu6m7Wwip0uGthe+ih
O3rko36nq5p4ya978z9TDfGRZA10gMYMEMDG+xmLDmc/4dQlvKx6lk+SIbneJFji
wmpLQSBdalbn6ay4mYpn7z2/MRiCnI42HwHAhSdys2MD9HeUspAjoQDjAtP775pu
qCitjRMX1neNGV4WOlJnumN9mzP7bCagrEBdC8RQwuer7SS+i7IaOPMCAQI=
-----END DH PARAMETERS-----' # OVERRIDE ME

default['serverbase']['nodeserver']['node_domain'] = '127.0.0.1:3000'
default['serverbase']['nodeserver']['url'] = 'http://127.0.0.1:3000'
default['serverbase']['nodeserver']['web_root'] = '/srv/www'
# default['serverbase']['nodeserver']['log_path'] = "#{node['serverbase']['nodeserver']['web_root']}/#{node['serverbase']['web']['site_name']}/logs/"
default['serverbase']['nodeserver']['temp_path'] = "temp" # i.e. '/srv/www/temp'
default['serverbase']['nodeserver']['starter_script'] = 'server.js' # OR 'app.js'
default['serverbase']['nodeserver']['service_path'] = '/etc/init.d/' # OR '/etc/systemd/system/'
default['serverbase']['nodeserver']['service_name'] = "mywebsited" # OR 'mywebsite.service' # OVERRIDE ME
default['serverbase']['nodeserver']['node_path'] = "/usr/local/src/nvm/versions/node/v%{version}/bin/node"

default['serverbase']['mongoserver']['instance_name'] = "mywebsite-mongodb" # OVERRIDE ME
default['serverbase']['mongoserver']['primary_database'] = 'admin'
default['serverbase']['mongoserver']['secondary_database'] = node['serverbase']['web']['site_name']
default['serverbase']['mongoserver']['admin_name'] = 'admin'
default['serverbase']['mongoserver']['account_name'] = 'dbadm1n' # OVERRIDE ME


###### OVERWRITE DEPENDENT ATTRIBUTES #####

# nginx settings
default['nginx']['version'] = '1.14.0'
default['nginx']['user'] = 'www-data'
default['nginx']['group'] = 'www-data'
default['nginx']['client_max_body_size'] = '2M'  # https://www.cyberciti.biz/faq/linux-unix-bsd-nginx-413-request-entity-too-large/

# nodejs settings
node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['version'] = node['serverbase']['node_version'] #'8.9.4' # https://nodejs.org/dist/  OR https://nodejs.org/dist/v9.8.0/
node.default['nodejs']['binary']['checksum'] = node['serverbase']['node_checksum'] #'21fb4690e349f82d708ae766def01d7fec1b085ce1f5ab30d9bda8ee126ca8fc' for node-v9.8.0-linux-x64.tar.gz

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

