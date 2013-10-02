helpers do

  def make_new_player
    @player = Player.create(name: params[:name])
  end

  def set_player_session
    session['player_id'] = @player.id
  end

  def set_game_session
    @game_id = (session[:game_id] = params[:id])
  end

  def setup_game
    unless session[:player_id]
      get_current_game
      make_new_player
      set_player_session
      add_player_to_game
    end
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

  def get_current_player
    @current_player = @game.players.order('updated_at').first
  end

  def get_previous_player
    @previous_player = @game.players.order('updated_at').last
  end

  def check_bullshit
    get_previous_player
    if @previous_player.bullshit
      n = @previous_player.number_of_dice
      @previous_player.number_of_dice = n-1
      @previous_player.save
    else
      n = @player.number_of_dice
      @player.number_of_dice = n-1
      @player.save
    end
  end

  def make_roll
    @player.current_roll = params['data'].join('')
    @player.save
  end

  def make_claim
    @player.current_claim = "#{params[:numDice]}x#{params[:dieValue]}"
    @player.check_lie
    @player.save
  end

  def destroy_player
    if session['player_id']
      get_player
      @player.destroy
      session.clear
    end
  end
  
end