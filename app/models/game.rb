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
  #validates :placeholder_team_1, presence: {if: lambda { |game| !game.has_team_1? }}, :length => {:minimum => 3, :maximum => 64}, :technical_name_allowed_chars => true, :allow_blank => true
  #validates :placeholder_team_2, presence: {if: lambda { |game| !game.has_team_2? }}, :length => {:minimum => 3, :maximum => 64}, :technical_name_allowed_chars => true, :allow_blank => true

  scope :order_by_game_number, lambda { order('game_number ASC') }

  def has_team_1?
    !team_1.nil?
  end

  def has_team_2?
    !team_2.nil?
  end
end
