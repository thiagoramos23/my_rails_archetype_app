require "bundler/capistrano"
require "rvm/capistrano"

set :base_path, "/var/www/rails/gmd.com.br"

set :application, "gmd.com.br"

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] =  ["~/.ssh/id_rsa"]
set :deploy_via, :remote_cache
set :user, "passenger"
set :use_sudo, false

# repo details
set :scm, :git
set :repository,  "git@bitbucket.org:rogalabs/gmd.git"
set :git_enable_submodules, 1
# set the defaults, can be overwritten with the -S flag
# example: cap deploy -S loc=stage -S branch=admin
set :loc, "dev" unless variables[:loc]
set :branch, "master" unless variables[:branch]

case loc
 when "prod"
   set :whenever_command, "bundle exec whenever"
   require "whenever/capistrano"
   
   load "deploy/assets"

   set :rvm_ruby_string, 'ruby-1.9.3-p484@gmd_novo.com.br'
   set :gemset_location, '/home/passenger/.rvm/gems/ruby-1.9.3-p484@gmd_novo.com.br'
   set :deploy_to, "#{base_path}/prod"
   set :rails_env, 'production'
   set :db_user, "gmd"
   set :db_pass, "gmd"
   set :db_name, "gmd"
   server "162.243.126.135", :app, :web, :db, :primary => true


   after "deploy", "deploy:migrate"
 when "stage"
   load "deploy/assets"

   set :rvm_ruby_string, 'ruby-1.9.3-p484@stage.gmd_novo.com.br'
   set :gemset_location, '/home/passenger/.rvm/gems/ruby-1.9.3-p484@stage.gmd_novo.com.br'
   set :deploy_to, "#{base_path}/stage"
   set :rails_env, 'stage'
   set :db_user, "gmd"
   set :db_pass, "gmd"
   set :db_name, "gmd_stage"
   server "162.243.126.135", :app, :web, :db, :primary => true

   after "deploy", "deploy:migrate"
 when "dev"
   set :rvm_ruby_string, 'ruby-1.9.3-p484@dev.gmd_novo.com.br'
   set :gemset_location, '/home/passenger/.rvm/gems/ruby-1.9.3-p484@dev.gmd_novo.com.br'
   set :deploy_to, "#{base_path}/dev"
   set :rails_env, 'development'
   set :db_user, "gmd"
   set :db_pass, "gmd"
   set :db_name, "gmd_development"
   server "162.243.126.135", :app, :web, :db, :primary => true


   after "deploy", "deploy:migrate"
 else
   raise "unsupported staging environment: #{loc}"
end

# if the branch flag isn't used, default to the master branch
if branch.nil?
  set :branch, "master"
else
  set :branch, branch
end

set :default_environment, {
  'PATH' => "#{gemset_location}/bin:/home/passenger/.rvm/gems/ruby-1.9.3-p484@global/bin:/home/passenger/.rvm/rubies/ruby-1.9.3-p484/bin:/home/passenger/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
  'RUBY_VERSION' => 'ruby ruby-1.9.3-p484',
  'GEM_HOME'     => gemset_location,
  'GEM_PATH'     => gemset_location,
  'BUNDLE_PATH'  => "#{gemset_location}/bin"  # If you are using bundler.
}

# add trace to rake for testing
#set :rake, "#{rake} --trace"

before 'deploy', 'rvm:create_gemset'
before "deploy", "deploy:create_release_dir"
# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :create_release_dir, :except => {:no_release => true} do
    run "mkdir -p #{fetch :releases_path}"
    run "mkdir -p #{shared_path}/log"
    run "mkdir -p #{shared_path}/pids"
    run "mysql --user=#{db_user} --password=#{db_pass} -e 'CREATE DATABASE IF NOT EXISTS #{db_name}'"
    # run "mysql --user=#{db_user} --password=#{db_pass} -e \"GRANT ALL PRIVILEGES ON #{db_name}.* TO #{db_user}@localhost IDENTIFIED BY '#{db_pass}'\""
  end
  task :start do ; end
  task :stop do ; end
  task :set_rails_env do
    tmp = "#{current_release}/tmp/environment.rb"
    final = "#{current_release}/config/environment.rb"
    run <<-CMD
      echo 'RAILS_ENV = "#{rails_env}"' > #{tmp};
      cat #{final} >> #{tmp} && mv #{tmp} #{final};
    CMD
  end
  task :symlink_restart_file do
    run "ln -s #{shared_path}/restart.txt #{release_path}/tmp/restart.txt"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:finalize_update", "deploy:set_rails_env"
after "deploy:update_code", "deploy:symlink_restart_file"
