#
# Cookbook Name:: ipboard_proxy
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apache2"
include_recipe "apache2::mod_proxy_html"
