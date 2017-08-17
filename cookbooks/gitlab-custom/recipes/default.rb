#
# Cookbook:: gitlab-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory '/home/git' do
  owner 'deploy'
  group 'deploy'
  mode '0755'
  action :create
end

directory '/home/git/repositories' do
  owner 'deploy'
  group 'deploy'
  mode '2770'
  action :create
end
