class Tip < ActiveRecord::Base

  extend RecordBatchUpdatable
  include TipRepository
  extend TipQueries
  include ScoreValidatable

  RESULTS = {incorrect: 0, correct: 1, correct_tendency_only: 2 }
  MISSED = -99

  belongs_to :user
  belongs_to :match

  validates :match, presence: true
  validates :user, presence: true
  validates :match_id, uniqueness: {scope: :user_id}

  validate :scores_not_changeable_after_match_started

  def tippable?
    !match.started?
  end

  def tipped?
    score_team_1? && score_team_2?
  end

  def points
    case result
      when RESULTS[:incorrect]
        Ggp2.config.incorrect_tip_points
      when RESULTS[:correct]
        Ggp2.config.correct_tip_points
      when RESULTS[:correct_tendency_only]
        Ggp2.config.correct_tendency_tip_only_points
      else
        nil
    end
  end

  def correct?
    result == RESULTS[:correct]
  end

  def correct_tendency_only?
    result == RESULTS[:correct_tendency_only]
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
