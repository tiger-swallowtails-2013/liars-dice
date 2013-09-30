$LOAD_PATH << "."
require 'config'
require "./app/routes"

run Sinatra::Application
