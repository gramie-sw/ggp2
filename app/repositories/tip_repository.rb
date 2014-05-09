module TipRepository
  extend ActiveSupport::Concern

  included do
    scope :all_by_match_id, ->(match_id) { where(match_id: match_id) }
    scope :all_by_result, ->(result) { where(result: result) }
    scope :all_by_user_id, ->(user_id) {where(user_id: user_id)}
    scope :finished_match, -> { joins(:match).where('matches.score_team_1 IS NOT NULL AND matches.score_team_2 IS NOT NULL')}
    scope :group_by_user_with_at_least_tips, ->(count) do
      select(:user_id).group(:user_id).having("count(user_id) >= ?", count)
    end
    scope :not_tipped, -> { where("score_team_1 IS NULL AND score_team_2 IS NULL") }
    scope :order_by_match_position, -> { joins(:match).order('matches.position').references(:matches) }
    scope :tipped, -> { where("score_team_1 IS NOT NULL AND score_team_2 IS NOT NULL") }
  end

  module ClassMethods

    def update_multiple_tips tips
      Tip.transaction do
        tips.map(&:save).all? || raise(ActiveRecord::Rollback)
      end
    end

    def ordered_results_by_user_id user_id
      all_by_user_id(user_id).order_by_match_position.pluck(:result)
    end

    def missed_tips
      not_tipped.finished_match
    end

    def user_ids_with_at_least_result_tips(result:, count:)
      all_by_result(result).group_by_user_with_at_least_tips(count).pluck(:user_id)
    end

    # def user_ids_with_at_least_missed_tips(count:)
    #   missed_tips.group_by_user_with_at_least_tips(count).pluck(:user_id)
    # end
  end
end