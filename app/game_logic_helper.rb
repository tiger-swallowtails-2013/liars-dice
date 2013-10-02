helpers do

  def make_new_player
    @player = Player.create(name: params[:name])
  end

  def set_player_session
    session['player_id'] = @player.id
  end

  def get_current_game
    @game = Game.find_by(id: session[:game_id])
  end

  def add_player_to_game
    @game.players << @player
  end

  def get_player
    @player = Player.find_by(id: session['player_id'])
  end

  def i_am_the_current_player?
    session[:player_id] == get_current_player.id
  end

  def get_current_player #player with oldest timestamp
    @current_player = @game.players.order('updated_at').first
    #current_p == nil ? nil : current_p.id
  end

  def get_previous_player
    get_current_game
    @previous_player = @game.players.order('updated_at').last
    #@previous_player.id
  end

  def get_game(player)
    player.game_id
  end
end