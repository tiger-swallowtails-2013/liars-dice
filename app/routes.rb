enable :sessions

get '/' do
  if session['player_id']
    @player = get_player()
    @game = get_game(@player)
    erb :play
  else
    erb :index
  end
end

post '/play' do
  @player = Player.create(params)
  set_player_session(@player.id)
  @player.roll
  @player.game = Game.create
  erb :play
end

post '/claim' do
  @player = get_player
  @player.current_claim = "#{params[:numDice]}x#{params[:dieValue]}"
  p @player
end

get '/exit' do
  if session['player_id']
    player = get_player()
    player.destroy
    session.clear
  end
  redirect '/'
end

helpers do
  def set_player_session(player_id)
    session['player_id'] = player_id
  end

  def get_player
    player_id = session['player_id']
    player = Player.find_by id: player_id
    return player
  end

  def get_game(player)
    return player.game_id
  end
end