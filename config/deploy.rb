# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '3.7.0'

set :application, 'my_app_name'
set :repo_url, 'git@github.com:andmorefine/since-co.git'

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :confirm do
    on roles(:app) do
      puts "This stage is '#{fetch(:stage)}'. Deploying branch is '#{fetch(:branch)}'."
      puts 'Are you sure? [y/n]'
      ask :answer, 'n'
      if fetch(:answer) != 'y'
        puts 'deploy stopped'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  before :starting, :confirm
end
