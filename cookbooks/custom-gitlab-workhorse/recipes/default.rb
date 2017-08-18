#
# Cookbook:: custom-gitlab-workhorse
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
execute 'sudo -u deploy -H bundle exec rake "gitlab:workhorse:install[/home/git/gitlab-workhorse]" RAILS_ENV=production' do
  cwd '/data/gitlabce/current'
  only_if { File.exist?("/data/gitlabce/current") }
end