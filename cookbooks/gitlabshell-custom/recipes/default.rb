#
# Cookbook:: gitlabshell-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if %w[util app app_master].include?(node['dna']['instance_role'])
  gitlabshell_secret_path = '/home/git/gitlab-shell/.gitlab_shell_secret'

  file gitlabshell_secret_path do
    action :delete
  end

  redis_conf = YAML.load_file('/data/gitlabce/shared/config/redis.yml')
  redis_url = redis_conf['production']['host'] + ':' + redis_conf['production']['port'].to_s

  execute "sudo -u deploy bundle exec rake gitlab:shell:install REDIS_URL=redis://#{redis_url} RAILS_ENV=production SKIP_STORAGE_VALIDATION=true" do
    cwd '/data/gitlabce/current/'
    only_if { File.exist?('/data/gitlabce/current') }
  end

  execute "sudo -u deploy ./gitlab-shell" do
    cwd '/home/git/gitlab-shell/bin/'
    only_if { File.exist?('/home/git/gitlab-shell/bin/gitlab-shell') }
  end
end