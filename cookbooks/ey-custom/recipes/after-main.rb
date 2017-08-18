include_recipe "custom-redis"
include_recipe 'gitlab-custom'
include_recipe 'gitlabdb-custom'
#include_recipe 'envyable-custom'
include_recipe 'gitlabshell-custom'
include_recipe 'custom-gitlab-workhorse'
include_recipe 'custom-go'