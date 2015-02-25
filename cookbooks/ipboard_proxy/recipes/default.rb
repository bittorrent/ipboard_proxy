#
# Cookbook Name:: ipboard_proxy
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apache2"
%w(proxy proxy_ajp ssl proxy_http rewrite deflate headers proxy_balancer
	proxy_connect substitute xml2enc).each do |apache_mod|
	include_recipe "apache2::mod_#{apache_mod}"
end

apache_module 'proxy_html' do
	conf true
end

%w(gd_bundle-g2-g1.crt star_getsync_com.crt star_getsync_com.key).each do |f|
	cookbook_file f do
		path "/etc/apache2/ssl/#{f}"
		owner 'root'
		group 'root'
		mode 0600
	end
end

web_app "forum.getsync.com" do
	server_name "forum.getsync.com"
	server_aliases [ node['hostname'] ]
	template "forum.getsync.com.conf.erb"
	docroot "/var/www/html"
end
