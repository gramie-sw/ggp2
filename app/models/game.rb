class Game < ActiveRecord::Base

  belongs_to :aggregate
  belongs_to :team_1, :class_name => "Team"
  belongs_to :team_2, :class_name => "Team"

  validates :game_number, presence: true, uniqueness: true, numericality: {only_integer: true}, inclusion: {in: 1..1000}
  validates :aggregate_id, presence: true
  validates :aggregate, presence: true
  validates :team_1, presence: {if: :team_1_id}
  validates :team_2, presence: {if: :team_2_id}
  validates :score_team_1, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true
  validates :score_team_2, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true
  validates :placeholder_team_1, presence: {if: lambda { |game| !game.has_team_1? }}, length: {minimum: 3, maximum: 64}, technical_name_allowed_chars: true, allow_blank: true
  validates :placeholder_team_2, presence: {if: lambda { |game| !game.has_team_2? }}, length: {minimum: 3, maximum: 64}, technical_name_allowed_chars: true, allow_blank: true
  validates :date, presence: true
  validate :validate_placeholder_team_1_not_eq_placeholder_team_2_besides_nil_or_blank
  validate :validate_team_1_not_equal_team_2

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

  scope :order_by_game_number, lambda { order('game_number ASC') }

  def has_team_1?
    !team_1.nil?
  end

  def has_team_2?
    !team_2.nil?
  end
end