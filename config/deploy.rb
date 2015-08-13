require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, '119.254.101.120'
set :branch, 'master'

set :user, 'deploy'
set :forward_agent, true
set :port, 9527

set :deploy_to, '/home/deploy/qiniu-nrop'
set :current_path, 'current'
set :app_path,  "#{deploy_to}/#{current_path}"

set :repository, 'git@github.com:rudyboy/geeklab-qiniu-nrop.git'
set :keep_releases, 5

set :shared_paths, [
  'config/database.yml',
  'config/application.yml',
  'tmp',
  'log'
]

task :environment do
  queue! 'source ~/.bashrc'
  invoke :'rvm:use[ruby-2.2.0]'
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue! %[touch "#{deploy_to}/shared/config/application.yml"]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:cleanup'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    to :launch do
      invoke :'thin:restart'
    end
  end
end

namespace :thin do
  desc "Start thin"
  task start: :environment do
    queue 'echo "-----> Start thin"'
    queue! %{
      cd #{app_path}
      bundle exec thin -e production -C "#{app_path}/config/thin.yml" -R config.ru -d start
    }
  end

  desc "Stop thin"
  task stop: :environment do
    queue 'echo "-----> Stop thin"'
    queue! %{
      cd #{app_path}
      ls tmp/pids | grep thin && echo "some server is running " && bundle exec thin stop -C "#{app_path}/config/thin.yml" && echo "not running & stop success"
    }
  end

  desc "Restart thin"
  task restart: :environment do
    invoke :'thin:stop'
    invoke :'thin:start'
  end
end