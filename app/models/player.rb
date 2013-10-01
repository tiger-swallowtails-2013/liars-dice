class Player < ActiveRecord::Base
  belongs_to :game

  def roll
    self.current_roll = ""
    6.times {self.current_roll << rand(6) + 1}
  end
end