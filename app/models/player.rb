class Player < ActiveRecord::Base
  belongs_to :game
  validate :claim_format
  after_save :check_lie

  def roll
    rolls = []
    self.number_of_dice.times {rolls << rand(6) + 1}
    self.current_roll = rolls.sort.join
  end

  private

  def claim_format
    unless current_claim == nil
      if !( current_claim =~ /[1-5]{1}x[1-6]{1}/)
        errors.add(:current_claim, "can't be in that format")
      end
    end
  end

  def check_lie
    unless current_claim == nil
      match = /[#{current_claim[2]}]{#{current_claim[0]}}/
      (current_roll.to_s =~ match).nil? ? self.bullshit = true : self.bullshit = false
    end

  end
end