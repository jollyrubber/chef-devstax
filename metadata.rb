name             'chef-devstax'
maintainer       'Juan Ayala'
maintainer_email 'juan.ayala.tech@gmail.com'
license          'All rights reserved'
description      'Installs/Configures chef-devstax'
long_description 'Installs/Configures chef-devstax'
version          '0.2.0'

supports "ubuntu"
supports "windows"

# ubuntu
depends "apt"
depends "ark"
depends "java"
depends "apache2"
depends "php"
depends "python"
depends "git"
depends "curl"

# windows
depends	"windows"

# ubuntu
recipe	"chef-devstax::composer", "Install Composer for PHP [Ubuntu]"
recipe	"chef-devstax::eclipse_prereqs", "Install required apt packages for Eclipse [Ubuntu]"
recipe	"chef-devstax::filevault", "Install Apache FileVault[Ubuntu]"
recipe	"chef-devstax::giteye", "Install GitEye git client [Ubuntu]"
recipe	"chef-devstax::gitflow", "Install git flow [Ubuntu]"
recipe	"chef-devstax::hosts", "Update the hosts file [Ubuntu]"
recipe	"chef-devstax::ondrej_ppa", "Add the Ondřej Surý PHP personal package archive (PPA) to apt-get [Ubuntu]"
recipe	"chef-devstax::phpvhosts", "Add Apache vhosts configured for PHP [Ubuntu]"
recipe	"chef-devstax::pythonvhosts", "Add Apache vhosts configured for Python [Ubuntu]"

# windows
recipe	"chef-devstax::visualstudio", "Install Visual Studio [Windows]"
recipe	"chef-devstax::mssql", "Install SQL Server [Windows]"