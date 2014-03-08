class MatchResult
  include ActiveModel::Model
  include ScoreValidatable

  delegate :message_name, to: :match

  validate :validate_match_id
  attr_accessor :match_id, :score_team_1, :score_team_2

  alias :score_team_1? :score_team_1
  alias :score_team_2? :score_team_2

  def save
    if valid?
      match
      @match.score_team_1= score_team_1
      @match.score_team_2= score_team_2
      @match.save
    end
  end

  def set_user_tip_points

  end

  def match
    @match ||= Match.find(match_id)
  end

  private

  def validate_match_id
    errors.add(:match_id, I18n.t('errors.messages.invalid')) unless Match.exists? match_id
  end
end