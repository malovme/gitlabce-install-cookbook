#
# Cookbook:: gitlab-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
%w[ /home/git /home/git/repositories].each do |path|
  directory '' do
    owner 'deploy'
    group 'deploy'
    mode '0755'
    action :create
  end
end