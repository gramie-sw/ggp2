module ScoreValidatable
  extend ActiveSupport::Concern

  included do
    #score_team_1 must be present if score_team_2 is present and vice versa
    validates :score_team_1, presence: true, if: :score_team_2?
    validates :score_team_1, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000},
              allow_nil: true
    validates :score_team_2, presence: true, if: :score_team_1?
    validates :score_team_2, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000},
              :allow_nil => true
  end
end