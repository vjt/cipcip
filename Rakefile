require 'rake'
require 'sinatra'

load 'lib/boot.rb'

namespace :db do
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
