class Tip < ActiveRecord::Base

  extend RecordBatchUpdatable
  include ScoreValidatable

  RESULTS = {
      incorrect: 0,
      correct: 1,
      #we use the therm tendency instead of winner because it includes draw matches
      correct_tendency_only: 2,
      correct_tendency_with_score_difference: 3,
      correct_tendency_with_one_score: 4
  }
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
    result.present? ? Ggp2.config.send("#{RESULTS.key(result)}_tip_points") : 0
  end

  def correct?
    result == RESULTS[:correct]
  end

  def set_result(match)
    if tip_is_correct?(match)
      self.result = Tip::RESULTS[:correct]
    elsif tip_has_correct_tendency?(match)
      set_correct_tendency_result(match)
    else
      self.result = Tip::RESULTS[:incorrect]
    end
  end

  private

  def set_correct_tendency_result(match)
    if tip_has_correct_score_difference?(match)
      self.result = Tip::RESULTS[:correct_tendency_with_score_difference]
    elsif tip_has_at_least_one_correct_score?(match)
      self.result = Tip::RESULTS[:correct_tendency_with_one_score]
    else
      self.result = Tip::RESULTS[:correct_tendency_only]
    end
  end

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

  def tip_has_correct_score_difference?(match)
    (score_team_1 - score_team_2) == (match.score_team_1 - match.score_team_2)
  end

  def tip_has_at_least_one_correct_score?(match)
    score_team_1 == match.score_team_1 || score_team_2 == match.score_team_2
  end
end
