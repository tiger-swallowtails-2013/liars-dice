class Game < ActiveRecord::Base
  has_many :players
  serialize :turns
end
