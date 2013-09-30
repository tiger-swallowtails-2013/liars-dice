config = File.dirname("../config")
$LOAD_PATH.unshift(config) unless $LOAD_PATH.include?(config)
require "config"

get '/' do
  erb :index
end

get '/play' do
  erb :play
end
