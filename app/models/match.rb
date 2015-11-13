class Match < ActiveRecord::Base

  extend MatchRepository
  include ScoreValidatable

  belongs_to :aggregate
  has_many :tips, dependent: :destroy
  has_many :ranking_items, dependent: :destroy

  validates :position, presence: true, uniqueness: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 1000}
  validates :aggregate_id, presence: true
  validates :aggregate, presence: true
  validates :date, presence: true
  validate :validate_placeholder_team_1_not_eq_placeholder_team_2_besides_nil_or_blank
  validate :validate_team_1_not_equal_team_2

  [:team_1, :team_2].each do |attribute|
    belongs_to attribute, class_name: :Team

    validates attribute, presence: {if: "#{attribute}_id"}
    validates "placeholder_#{attribute}",
              presence: {if: lambda { |match| match.send(attribute).nil? }},
              length: {minimum: 3, maximum: 64}, technical_name_allowed_chars: true, allow_blank: true
  end

  def clear_result
    self.score_team_1 = nil
    self.score_team_2 = nil
  end

  def has_result?
    score_team_1.present? && score_team_2.present?
  end

  def message_name
    "#{Match.model_name.human} #{position}"
  end

  def started?
    date.past?
  end

  def tippable?
    !started?
  end

  def winner_team
    if has_result? && score_team_1 != score_team_2
      score_team_1 > score_team_2 ? team_1 : team_2
    end
  end

  #TODO test or remove
  def self.score_or_dash team_score
    team_score.nil? ? "-" : team_score
  end

  def phase
    if aggregate.parent.present?
      aggregate.parent
    else
      aggregate
    end
  end

  private

  def validate_placeholder_team_1_not_eq_placeholder_team_2_besides_nil_or_blank
    if placeholder_team_1 == placeholder_team_2
      unless placeholder_team_1 == nil or placeholder_team_1 == ""
        errors[:placeholder_team_2]<< I18n.t('errors.messages.must_not_equals_team_1_placeholder')
      end
    end
  end

  def validate_team_1_not_equal_team_2
    if team_1 == team_2
      unless team_1 == nil or team_1 == ""
        errors[:team_2]<< I18n.t('errors.messages.must_not_equals_team_1')
      end
    end
  end
end