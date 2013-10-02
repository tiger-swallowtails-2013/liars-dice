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
      lose_one_die(@previous_player)
    else
      lose_one_die(@player)
    end
  end

  def lose_one_die(player)
    less_dice = player.number_of_dice - 1
    player.update_attribute(:number_of_dice, less_dice)
    game_over(player) if less_dice <= 0
  end

  def game_over(player)
    player.destroy
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