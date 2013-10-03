$LOAD_PATH << "."
require 'sinatra/activerecord/rake'
require 'config'

# Use the following to control with environment is set
# RACK_ENV=test rake db:create
desc "create database"
task "db:create" do
  puts "Creating file #{DB_PATH} if it doesn't exist..."
  touch DB_PATH
end

desc "drop dev database"
task "db:drop" do
  rm_f DB_PATH
end

desc "create test database"
task "db:create-test" do
  exec "rake RACK_ENV=test db:create"
end

desc "drop test database"
task "db:drop-test" do
  exec "rake RACK_ENV=test db:drop"
end

desc "migrate test database"
task "db:migrate-test" do
  exec "rake RACK_ENV=test db:migrate"
end
begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
