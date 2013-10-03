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
  get_current_player
  if i_am_the_winner?
   redirect '/winner'
  else
    erb :play
  end
end

get '/test.json' do
  players = Player.all
  json players
end

post '/refresh_check' do
  get_player
  get_current_game
  get_current_player
  results_hash = {}
  results_hash["waiting"] = erb :_player_queue, :layout => false
  if i_am_the_current_player?
    results_hash["current"] = "<h1>Test Successful</h1>"
    # results_hash["current"] = erb :_my_turn, :layout => false
  end
  # p results_hash
  # p json results_hash
  # p session
  json results_hash

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
  "YOU ARE THE WINNER"
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