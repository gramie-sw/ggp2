class MatchResult
  include ActiveModel:Model

  attr_acessor :match_id, :score_team_1, :score_team_2

  validates :match_id, numericality: {only_integer:  true}, allow_nil: false
  validates :score_team_1, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true
  validates :score_team_2, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true

end