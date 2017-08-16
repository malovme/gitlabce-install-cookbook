#
# Cookbook:: gitlabshell-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

current_path = "/data/gitlabce/current"
failed_path = "/data/gitlabce/releases_failed"

if File.exist?(current_path)
  release_dir = current_path
else
  release_dir =  Dir.entries(failed_path).select {|entry| File.directory? File.join(failed_path, entry) and !(entry =='.' || entry == '..') }.last
end

execute 'bundle exec rake gitlab:shell:install REDIS_URL=unix:/var/run/redis/redis.sock RAILS_ENV=production SKIP_STORAGE_VALIDATION=true' do
  cwd release_dir
end