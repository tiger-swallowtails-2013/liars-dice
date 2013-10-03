require_relative './game_logic_helper'
enable :sessions

get '/' do
  # if session['player_id']
  #   get_player
  #   get_current_game
  # else
    erb :index
  # end
end

get '/join/:id' do
  set_game_session
  erb :join
end

post '/play' do
  setup_game
  redirect '/play'
end

get '/play' do
  get_player
  get_current_game
  get_current_player
  erb :play
end

post '/rolls' do
  get_player
  make_roll
  redirect '/play'
end

post '/claim' do
  get_player
  make_claim
  redirect '/play'
end

post '/bullshit' do
  get_player
  get_current_game
  check_bullshit!
  redirect '/play'
end

get '/exit' do
  destroy_player
  redirect '/'
end

get '/wipe' do
  session.clear
  Game.create
  redirect '/wipe'
end