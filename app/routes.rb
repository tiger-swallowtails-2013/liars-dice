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
  #if i_am_the_winner?
  #  redirect '/winner' #bounces player 1
  #else
    get_player
    get_current_game
    get_previous_player
    get_current_player
    erb :play
  #end
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