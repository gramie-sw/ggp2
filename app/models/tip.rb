class Tip < ActiveRecord::Base

  extend RecordBatchUpdatable
  include ScoreValidatable

  RESULTS = {correct: 0, incorrect: 1, correct_tendency: 2}

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

  def points
    case result
      when RESULTS[:correct]
        Ggp2.config.correct_tip_points
      when RESULTS[:incorrect]
        Ggp2.config.incorrect_tip_points
      when RESULTS[:correct_tendency]
        Ggp2.config.correct_tendency_tip_points
      else
        nil
    end
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
