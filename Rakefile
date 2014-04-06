#!/usr/bin/env rake
# encoding: UTF-8
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)


Herbs::Application.load_tasks

desc "rebuild search index"
task :search => :environment do
  # crontask
  # 30 1 * * *  cd /path/to/site  && RAILS_ENV=production /usr/local/bin/rake search >> /path/to/site/log/cron.log 2>> /path/to/site/log/cron_error.log
  t = Time.new
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
  ActsAsFerret.rebuild_index(SearchController::INDEX_NAME)
  puts "Completed in #{(Time.new - t)}"
end
