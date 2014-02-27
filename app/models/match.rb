class Match < ActiveRecord::Base

  belongs_to :aggregate
  belongs_to :team_1, :class_name => "Team"
  belongs_to :team_2, :class_name => "Team"
  belongs_to :venue
  has_many :tips, dependent: :destroy

  validates :position, presence: true, uniqueness: true, numericality: {only_integer: true}, inclusion: {in: 1..1000}
  validates :aggregate_id, presence: true
  validates :aggregate, presence: true
  validates :team_1, presence: {if: :team_1_id}
  validates :team_2, presence: {if: :team_2_id}
  #validates :score_team_1, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true
  #validates :score_team_2, numericality: {only_integer: true}, inclusion: {in: 0..1000}, allow_nil: true
  validates :placeholder_team_1, presence: {if: lambda { |match| !match.team_1? }}, length: {minimum: 3, maximum: 64}, technical_name_allowed_chars: true, allow_blank: true
  validates :placeholder_team_2, presence: {if: lambda { |match| !match.team_2? }}, length: {minimum: 3, maximum: 64}, technical_name_allowed_chars: true, allow_blank: true
  validates :date, presence: true
  validate :validate_placeholder_team_1_not_eq_placeholder_team_2_besides_nil_or_blank
  validate :validate_team_1_not_equal_team_2

  scope :order_by_position, -> { order('position ASC') }
  scope :future_matches, -> { where('matches.date > ?', Time.now) }

  def team_1?
    !team_1.nil?
  end

  def team_2?
    !team_2.nil?
  end

  def team_or_placeholder_1
    team_1? ? team_1.name : placeholder_team_1
  end

  def team_or_placeholder_2
    team_2? ? team_2.name : placeholder_team_2
  end

  def has_result?
    score_team_1.present? && score_team_2.present?
  end

  def message_name
    "#{Match.model_name.human}: #{position}  (#{team_or_placeholder_1} vs #{team_or_placeholder_2})"
  end

  def started?
    date.past?
  end

  def self.score_or_dash team_score
    team_score.nil? ? "-" : team_score
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