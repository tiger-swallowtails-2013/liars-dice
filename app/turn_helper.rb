
  def get_current_player
    @current_player = Player.find_by(id: @current_player_id)
  end

  def get_current_player_id
    @current_player_id = @game.turns[0]
  end

  def set_player_turn_number(player_id)
    @game.turns << player_id
  end

  def remove_loser(player_id)
    index = @game.turns.index(player_id)
    @game.turns.slice!(index)
  end

  def update_turn_order
    first = @game.turns.shift
    @game.turns << first
  end

  def current_player_is_winner?
    winner_may_exist = true
    i = 0
    while winner_may_exist && i < @game.turns.length
      player_id = @game.turns[i]
      unless get_current_player_id == player_id
        numDice = Player.find_by(id: player_id).number_of_dice
        winner_may_exist = false if numDice > 0
      end
      i += 1
    end
    if winner_may_exist == true
      return true 
    else
      return false
    end
  end