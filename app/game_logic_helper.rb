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