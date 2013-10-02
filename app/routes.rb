require_relative './game_logic_helper'
enable :sessions

get '/' do
  # if session['player_id']
  #   @player = get_player()
  #   @game = get_game(@player)
  #   erb :play
  # else
    erb :index
  # end
end

get '/join/:id' do
  @game_id = params[:id]
  session[:game_id] = @game_id
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
  @player = get_player
  @player.current_claim = "#{params[:numDice]}x#{params[:dieValue]}"
  @player.check_lie
  @player.save
  redirect '/play'
end

post '/bullshit' do
  get_player
  get_current_game
  get_previous_player
  if @player.bullshit
    @previous_player.number_of_dice -= 1
    @previous_player.save
  else
    number = @player.number_of_dice
    @player.number_of_dice = number-1
    @player.save
  end
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
  erb :wipe
end