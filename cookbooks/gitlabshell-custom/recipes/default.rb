#
# Cookbook:: gitlabshell-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if %w[util app app_master].include?(node['dna']['instance_role'])
  current_path = "/data/gitlabce/current"
  failed_path = "/data/gitlabce/releases_failed"

  if File.exist?(current_path)
    release_dir = current_path
  else
    release_dir = failed_path + '/' +
        Dir.entries(failed_path).select {|entry| File.directory? File.join(failed_path, entry) and !(entry =='.' || entry == '..') }.sort.last
  end

  gitlabshell_secret_path = '/home/git/gitlab-shell/.gitlab_shell_secret'

  file gitlabshell_secret_path do
    action :delete
  end

  redis_conf = YAML.load_file('/data/gitlabce/shared/config/redis.yml')
  redis_url = redis_conf['production']['host'] + ':' + redis_conf['production']['port'].to_s

  execute "sudo -u deploy bundle exec rake gitlab:shell:install REDIS_URL=redis://#{redis_url} RAILS_ENV=production SKIP_STORAGE_VALIDATION=true" do
    cwd release_dir
  end

  execute "sudo -u deploy ./gitlab-shell" do
    cwd '/home/git/gitlab-shell/bin/'
  end
end