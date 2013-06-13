class Game < ActiveRecord::Base

  belongs_to :aggregate
  belongs_to :team_1, :class_name => "Team"
  belongs_to :team_2, :class_name => "Team"

  scope :order_by_game_number, lambda { order('game_number ASC') }

end
