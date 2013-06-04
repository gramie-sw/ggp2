class Team < ActiveRecord::Base

  has_many :team_1_games, :class_name => "Game", :foreign_key => "team_1_id"
  has_many :team_2_games, :class_name => "Game", :foreign_key => "team_2_id"

  validates :name, presence: true, uniqueness: true
  validates :abbreviation, presence: true, uniqueness: true

end
