#
# Cookbook:: gitlab-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if File.exists?('/data/gitlabce/current') && !File.exists?('/data/gitlabce/current/public/uploads')
  directory '/data/gitlabce/current/public/uploads' do
    owner 'deploy'
    group 'deploy'
    mode '0755'
    action :create
  end
end

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
