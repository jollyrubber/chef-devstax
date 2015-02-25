return unless platform?("ubuntu")

include_recipe "php"
include_recipe "php::module_curl"
include_recipe "git"
include_recipe "curl"

bash "composer" do
  code <<-EOH
    curl -s https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
  EOH
end