class Tip < ActiveRecord::Base

  extend ModelBatchUpdatable

  belongs_to :user
  belongs_to :match

  validates :match, :presence => true
  validates :user, :presence => true

  #score_team_1 must be present if score_team_2 is present and vice versa
  validates :score_team_1, presence: true, if: :score_team_2?
  validates :score_team_1, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000},
            allow_nil: true
  validates :score_team_2, presence: true, if: :score_team_1?
  validates :score_team_2, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000},
            :allow_nil => true

  validates :points,
            numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000},
            allow_nil: true

  validate :scores_not_changeable_after_match_started

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
