helpers do

  def create_new_game
    @game = Game.create(turns: [])
  end

  def make_new_player
    @player = Player.create(name: params[:name])
  end

  def set_player_session
    session[:player_id] = @player.id
  end

  def set_game_session
    @game_id = (session[:game_id] = params[:id].to_i)
  end

  def setup_game_for_player
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
    @game.turns << @player.id
    @game.save
  end

  def get_player
    @player = Player.find_by(id: session['player_id'])
  end

  def i_am_the_current_player?
    session[:player_id] == get_current_player_id
  end

  def get_current_player_id
    @game.turns[0]
  end

  def get_current_player
    @current_player = Player.find_by(id: get_current_player_id)
  end

  def get_previous_player
    @previous_player = Player.find_by(id: @game.turns.last)
  end

  def update_turn_order
    @game.turns = @game.turns.rotate
    @game.save
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

  def check_bullshit!
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
    index = @game.turns.index(player.id)
    @game.turns.slice!(index)
    @game.save
  end

  def winner?
    @game.turns.count == 1
  end

  def i_am_the_winner?
    true if winner? && (session[:player_id] == @game.turns.first)
  end

  def destroy_player
    if session['player_id']
      get_player
      @player.destroy
      @player.save
      session.clear
    end
  end
  
end