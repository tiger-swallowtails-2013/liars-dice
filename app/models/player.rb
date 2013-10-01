class Player < ActiveRecord::Base
  belongs_to :game
  validate :claim_format
  after_save :check_lie

  def roll
    self.current_roll = ""
    6.times {self.current_roll << rand(6) + 1}
  end

  private

  def claim_format
    if !(current_claim =~ /[1-5]{1}x[1-6]{1}/)
      errors.add(:current_claim, "can't be in that format")
    end
  end

  def check_lie
    match = /[#{current_claim[2]}]{#{current_claim[0]}}/
    (current_roll.to_s =~ match).nil? ? self.bullshit = true : self.bullshit = false
  end
end