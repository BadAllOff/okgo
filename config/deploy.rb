# config valid only for current version of Capistrano
lock "3.8.1"

set :application, 'okgo'
set :repo_url, 'git@bitbucket.org:BadAllOffSH/okgo.git'
set :deploy_to, '/opt/www/okgo'
set :user, 'deploy'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle', 'public/uploads'
append :linked_files, 'config/database.yml'
set :keep_releases, 7


namespace :deploy do
  %w[start stop restart].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  after :publishing, :restart
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
