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

ssl_info = Chef::EncryptedDataBagItem.load('webcerts', 'star_getsync_com')

file '/etc/apache2/ssl/star_getsync_com.crt' do
	content ssl_info['single_cert']
	owner 'root'
	group 'root'
	mode 0600
	sensitive true
end

file '/etc/apache2/ssl/star_getsync_com.key' do
	content ssl_info['key']
	owner 'root'
	group 'root'
	mode 0600
	sensitive true
end

cookbook_file 'gd_bundle-g2-g1.crt' do
	path "/etc/apache2/ssl/gd_bundle-g2-g1.crt"
	owner 'root'
	group 'root'
	mode 0600
end

web_app "forum.getsync.com" do
	server_name "forum.getsync.com"
	server_aliases [ node['hostname'] ]
	template "forum.getsync.com.conf.erb"
	docroot "/var/www/html"
end
