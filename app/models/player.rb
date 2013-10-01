class Player < ActiveRecord::Base
  belongs_to :game
  validate :claim_format

  def claim_format
    if !(current_claim =~ /[1-5]{1}x[1-6]{1}/)
      errors.add(:current_claim, "can't be in that format")
    end
  end

end
