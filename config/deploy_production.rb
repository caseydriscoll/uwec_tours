require 'bundler/capistrano'
load 'deploy/assets'

default_environment["PATH"]="/opt/ree/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/games" 
set :application, ""
set :repository,  "svn://server"

set :user, ""
set :deploy_to, "/app/#{application}"
set :deploy_via, :copy
set :copy_strategy, :export
ssh_options[:port] = 22
set :use_sudo, false

set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :dbuser, "#{application}"
set :dbpassword, ""
set :dbhost, ""
set :dbname, "#{application}_production"

set :servername, ""
role :web, servername                          # Your HTTP server, Apache/etc
role :app, servername                          # This may be the same as your `Web` server
role :db,  servername, :primary => true 			 # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:setup", :config_db
after "deploy:finalize_update", "other_links"

task :other_links do
  run "rm -f #{release_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/database.yml #{release_path}/config/database.yml"
end

task :config_db do
        database_configuration = <<EOF
production:
  adapter: mysql2
  host: #{dbhost}
  username: #{dbuser}
  password: #{dbpassword}
  database: #{dbname}

EOF
run "mkdir -p #{deploy_to}/#{shared_dir}/config"
put database_configuration, "#{deploy_to}/#{shared_dir}/database.yml"
end

desc "tail production log files" 
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err    
  end
end

task :migrate_reset do
  puts "\n\n=== Resetting the Production Database! ===\n\n"
  run "cd #{current_path}; bundle exec rake db:migrate:reset RAILS_ENV=production; bundle exec rake db:seed RAILS_ENV=production"
end
