name             'chef-devstax'
maintainer       'Juan Ayala'
maintainer_email 'juan.ayala.tech@gmail.com'
license          'All rights reserved'
description      'Installs/Configures chef-devstax'
long_description 'Installs/Configures chef-devstax'
version          '0.1.0'

depends "apt"
depends "java"
depends "apache2"
depends "php"
depends "php::module_curl"
depends "git"
depends "curl"

supports "ubuntu"