class Game < ActiveRecord::Base

  belongs_to :aggregate
  belongs_to :team_1, :class_name => "Team"
  belongs_to :team_2, :class_name => "Team"
end
