# serverbase

Installs & configures serverbase, a MERN instance, which consists of an nginx front end backed by node.js and mongoDb on one instance. The intended target of this cookbook is for AWS on Amazon Linux.

## Build

Example optional build process using Berkshelf - :$ berks package serverbase.tar.gz

## Usage

Recipes in this cookbook are broken down into setup and configure components. While they can be organized how you'd like the recommended order is below:

- Setup  
include_recipe 'serverbase::init'  
include_recipe 'serverbase::users'  
include_recipe 'serverbase::structure'  
include_recipe 'serverbase::ssl'  
include_recipe 'serverbase::web'  
include_recipe 'serverbase::nodeserver'  
include_recipe 'serverbase::dbserver'  

- Configure  
include_recipe 'serverbase::mongodb_user_management'  
include_recipe 'serverbase::services'  

- Shutdown  
include_recepie 'serverbase::shutdown'  

## Tested On

Tested on Amazon Linux 2018.03 instance

## Author

[ethanpeterson](https://github.com/ethanpeterson)

## License

This project is licensed under the Apache 2.0 license. See the [LICENSE](LICENSE.md) file for more info.

Copyright (c) 2018