class MatchResult
  include ActiveModel::Model

  validates :match_id, numericality: {only_integer: true}, allow_nil: false
  validates :score_team_1, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true
  validates :score_team_2, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true

  attr_accessor :match_id, :score_team_1, :score_team_2

  def initialize id
    @match_id = id
    set_score_values
  end

  private

  def set_score_values
    match = Match.find(match_id)
    @score_team_1 = match.score_team_1
    @score_team_2 = match.score_team_2
  end
end