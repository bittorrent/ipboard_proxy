#
# Cookbook Name:: ipboard_proxy
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apache2"
%w(proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer
	proxy_connect proxy_html).each do |apache_mod|
	include_recipe "apache2::mod_#{apache_mod}"
end

web_app "forum.getsync.com"
