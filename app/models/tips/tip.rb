class Tip < ActiveRecord::Base

  extend RecordBatchUpdatable
  include TipRepository
  extend TipQueries
  include ScoreValidatable

  RESULTS = {incorrect: 0, correct: 1, correct_tendency_only: 2}
  MISSED = -99

  belongs_to :user
  belongs_to :match

  validates :match, presence: true
  validates :user, presence: true
  validates :match_id, uniqueness: {scope: :user_id}

  validate :validate_scores_not_changeable_after_match_started

  def tippable?
    !match.started?
  end

  def tipped?
    score_team_1.present? && score_team_2.present?
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

  def set_result(match)
    if tip_is_correct?(match)
      self.result = Tip::RESULTS[:correct]
    elsif tip_has_correct_tendency?(match)
      self.result = Tip::RESULTS[:correct_tendency_only]
    else
      self.result = Tip::RESULTS[:incorrect]
    end
  end

  private

  def validate_scores_not_changeable_after_match_started
    if match.present? && !tippable?
      if (score_team_1 != score_team_1_was) || (score_team_2 != score_team_2_was)
        errors[:base] << I18n.t('errors.messages.scores_not_changeable_after_match_started')
      end
    end
  end

  def tip_is_correct?(match)
    score_team_1 == match.score_team_1 and score_team_2 == match.score_team_2
  end

  def tip_has_correct_tendency?(match)
    if tipped?
      ((score_team_1 - score_team_2) <=> 0) == ((match.score_team_1 - match.score_team_2) <=> 0)
    end
  end
end
