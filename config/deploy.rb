require 'cape'
require 'bundler/capistrano'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :use_sudo, false

set :application, 'come-home'
set :stage, :production
set :keep_releases, 1

server ENV['SQUID_SSH'], :app, :web, :db, :primary => true

set :repository, 'git@github.com:mikemartin/ComeHomeYear.git'
set :scm, :git
set :scm_verbose, true
set :branch, 'master'
set :deploy_via, :remote_cache

set :deploy_to, "/home/apucacao/#{stage}/#{application}"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

Cape do
  # mirror_rake_tasks :db
  # mirror_rake_tasks :build
end

after :deploy, 'deploy:restart'