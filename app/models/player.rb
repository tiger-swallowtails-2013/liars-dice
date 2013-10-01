class Player < ActiveRecord::Base
  belongs_to :game
  validate :claim_format
  before_update :check_lie


  private

  def claim_format
    if !(current_claim =~ /[1-5]{1}x[1-6]{1}/)
      errors.add(:current_claim, "can't be in that format")
    end
  end

  def check_lie
    if current_claim
    end
  end

end
