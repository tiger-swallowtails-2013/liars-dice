$LOAD_PATH << "."
require 'config'

# require 'sinatra'
require 'capybara/rspec'
# require 'routes.rb'
Capybara.app = Sinatra::Application
Capybara.javascript_driver = :webkit