$LOAD_PATH << "."
require 'sinatra/activerecord/rake'
require 'config'

# Use the following to control with environment is set
# RACK_ENV=test rake db:create
desc "create the database"
task "db:create" do
  puts "Creating file #{DB_PATH} if it doesn't exist..."
  touch DB_PATH
end

desc "drop the database"
task "db:drop" do
  puts "Dropping #{DB_PATH} if it exists..."
  exec 'rm -rf #{DB_PATH}'
end