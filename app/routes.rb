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

get '/wipe' do
  session.clear
  Game.create
  erb :wipe
end

get '/join/:id' do
  @game_id = params[:id]
  session[:game_id] = @game_id
  p @game_id
  erb :join
end

post '/rolls' do
  get_player
  @player.current_roll = params['data'].join('')
  @player.save
  p @player
  redirect '/play'
end

get '/play' do
  get_player
  current_game
  @current_player_boolean = am_i_the_current_player?
  @current_player = current_player
  #@player.roll ##
  erb :play
end

post '/play' do
  unless session[:player_id] && session[:game_id]
    new_player_and_session
    add_player_to_game
  end
  get_player
  current_game
  @current_player_boolean = am_i_the_current_player?
  @current_player = current_player
  #@player.roll ##
  erb :play
end

post '/bullshit' do
  get_player
  current_game
  previous_player
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

post '/claim' do
  @player = get_player
  @player.current_claim = "#{params[:numDice]}x#{params[:dieValue]}"
  @player.check_lie
  @player.save
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

helpers do

  def add_player_to_game
    current_game
    @game.players << @player
  end

  def current_game
    @game = Game.find_by(id: session[:game_id])
  end

  def new_player_and_session
    @player = Player.create(name: params[:name])
    set_player_session(@player.id)
  end

  def am_i_the_current_player?
    session[:player_id] == next_player_id
  end

  def next_player_id
    current_game
    next_p = @game.players.order('updated_at').first
    next_p == nil ? nil : next_p.id
  end

  def current_player
    @current_player = Player.find_by(id: next_player_id)
  end

  def previous_player
    current_game
    @previous_player = @game.players.order('updated_at').last
    @previous_player.id
  end

  def set_player_session(player_id)
    session['player_id'] = player_id
  end

  def get_player
    player_id = session['player_id']
    @player = Player.find_by id: player_id
    return @player
  end

  def get_game(player)
    return player.game_id
  end
end