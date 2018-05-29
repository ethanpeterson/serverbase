name 'serverbase'
maintainer 'Ethan Peterson'
maintainer_email 'you@example.com'
license 'Apache-2.0'
description 'Installs & configures serverbase - a MERN environment'
long_description 'Installs & configures serverbase, which consists of an nginx front end backed by node.js and mongoDb on one instance'
version '0.1.2'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/ethanpeterson/serverbase/issues'
source_url 'https://github.com/ethanpeterson/serverbase'

depends 'nginx', '~> 8.1.2'
depends 'nvm', '~> 0.1.7'
depends 'sc-mongodb', '~> 1.0.1'
depends 'swap', '~> 2.2.2' # applicable for Chef 13 and below - https://github.com/sous-chefs/swap
