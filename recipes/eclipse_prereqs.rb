include_recipe "apt"
include_recipe "java"

%w{ xauth libswt-gtk-3-java }.each do |p|
	apt_package p do
	  action "install"
	end
end