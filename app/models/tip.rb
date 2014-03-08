class Tip < ActiveRecord::Base

  extend RecordBatchUpdatable
  include ScoreValidatable
  include PointsValidatable

  belongs_to :user
  belongs_to :match

  validates :match, presence: true
  validates :user, presence: true
  validates :match_id, uniqueness: {scope: :user_id}

  validate :scores_not_changeable_after_match_started

  scope :match_tips, ->(match_id= nil) { where(match_id: match_id)}
  scope :order_by_match_position, -> { joins(:match).order('matches.position').references(:matches) }

  def tippable?
    !match.started?
  end

  private

  def scores_not_changeable_after_match_started
    if match.present? && !tippable?
      if (score_team_1 != score_team_1_was) || (score_team_2 != score_team_2_was)
        errors[:base] << I18n.t('errors.messages.scores_not_changeable_after_match_started')
      end
    end
  end
end
