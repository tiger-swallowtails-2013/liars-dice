require 'pathname'
require 'sinatra'
require 'sinatra/activerecord'
require 'app/models/game'
require 'app/models/player'
require 'tux' unless settings.production?
require 'sqlite3' unless settings.production?
require 'pg' if settings.production?

APP_ROOT = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '.')))
p APP_ROOT
VIEW_PATH = APP_ROOT.join('app','views').to_s
PUBLIC_PATH = APP_ROOT.join('public').to_s
PROJECT = File.basename(File.expand_path("."))

configure do
  set :views, VIEW_PATH
  set :public_folder, PUBLIC_PATH
  set :root, APP_ROOT.join("config")
end

if settings.production?
  set :database, ENV["DATABASE_URL"] ||= "postgresql://localhost/social_media"

else
  adapter = 'sqlite3'
  DB_NAME = settings.test? ? "#{PROJECT}_test.db" : "#{PROJECT}_dev.db"
  DB_PATH = "#{APP_ROOT}/db/#{DB_NAME}"
  ActiveRecord::Base.establish_connection :adapter  => adapter,
                                          :database => DB_NAME
end