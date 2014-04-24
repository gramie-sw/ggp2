module TipRepository
  extend ActiveSupport::Concern

  included do
    scope :all_by_match_id, ->(match_id) { where(match_id: match_id) }
    scope :order_by_match_position, -> { joins(:match).order('matches.position').references(:matches) }
    scope :tipped, -> { where("score_team_1 IS NOT NULL AND score_team_2 IS NOT NULL") }
  end

  module ClassMethods

    def update_multiple_tips tips
      Tip.transaction do
        tips.map(&:save).all? || raise(ActiveRecord::Rollback)
      end
    end
  end
end