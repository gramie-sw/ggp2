class MatchResult
  include ActiveModel::Model

  delegate :message_name, to: :match

  validates :match_id, numericality: {only_integer: true}, allow_nil: false
  validates :score_team_1, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true
  validates :score_team_2, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true

  attr_accessor :match_id, :score_team_1, :score_team_2

  def save
    match
    @match.score_team_1= score_team_1
    @match.score_team_2= score_team_2
    @match.save
  end

  def match
    @match ||= Match.find(match_id)
  end
end