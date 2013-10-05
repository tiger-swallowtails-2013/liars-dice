require_relative './game_logic_helper'
require 'sinatra/json'
enable :sessions

get '/' do
  # if session['player_id']
  #   get_player
  #   get_current_game
  # else
    erb :index
  # end
end

get '/create_game' do
  create_new_game
  "You've made a game"
end

get '/join/:id' do
  set_game_session
  erb :join
end

post '/play' do
  setup_game_for_player
  redirect '/play'
end

get '/play' do
  get_player
  get_current_game
  get_previous_player
  get_current_player
  if i_am_the_winner?
   redirect '/winner'
  else
    erb :play
  end
end

get '/refresh_game_board' do
  get_player
  get_current_game
  get_current_player
  p i_am_the_current_player?
  i_am_the_current_player? ? 400 : (erb :_player_queue, :layout => false)
end

get '/refresh_current_player' do
  get_player
  get_current_game
  get_current_player
  # 1 == 1 ? 200 : 400 success
  # 1 == 2 ? 200 : 400 fail
  p i_am_the_current_player?
  i_am_the_current_player? ? 200 : 400 
end

post '/rolls' do
  get_player
  make_roll
  redirect '/play'
end

post '/claim' do
  get_player
  get_current_game
  make_claim
  update_turn_order
  redirect '/play'
end

post '/bullshit' do
  get_player
  get_current_game
  check_bullshit!
  redirect '/play'
end

get '/winner' do
  erb :winner
end

get '/exit' do
  destroy_player
  redirect '/'
end

get '/wipe' do
  session.clear
  create_new_game
  redirect '/'
end