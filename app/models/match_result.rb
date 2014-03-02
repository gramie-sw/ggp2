class MatchResult
  include ActiveModel::Model

  delegate :message_name, to: :match

  validate :validate_match_id
  validates :score_team_1, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  validates :score_team_2, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  attr_accessor :match_id, :score_team_1, :score_team_2

  def save
    if valid?
      match
      @match.score_team_1= score_team_1
      @match.score_team_2= score_team_2
      @match.save
    end
  end

  def match
    @match ||= Match.find(match_id)
  end

  private

  def validate_match_id
    errors.add(:match_id, I18n.t('errors.messages.invalid')) unless Match.exists? match_id
  end
end