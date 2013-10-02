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
  unless session[:player_id] #&& session[:game_id]
    get_current_game
    make_new_player
    set_player_session
    add_player_to_game
  end
  redirect '/play'
end

get '/play' do
  get_player # from session
  get_current_game
  get_current_player
  erb :play
end

post '/rolls' do
  get_player
  @player.current_roll = params['data'].join('')
  @player.save
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
  check_bullshit
  redirect '/play'
end

get '/exit' do
  if session['player_id']
    get_player
    @player.destroy
    session.clear
  end
  redirect '/'
end

get '/wipe' do
  session.clear
  Game.create
  redirect 'wipe'
end