class Team < ActiveRecord::Base

  has_many :team_1_matches, class_name: :Match, foreign_key: :team_1_id, dependent: :restrict_with_exception
  has_many :team_2_matches, class_name: :Match, foreign_key: :team_2_id, dependent: :restrict_with_exception
  has_many :champion_tips, dependent: :nullify

  TYPES = ['countries', 'clubs']

  validates :team_code, presence: true, uniqueness: true, length: {maximum: 16}

  scope :order_by_team_name_asc, -> { all.sort_by { |team| I18n.t(team.team_code, :scope => 'teams') } }

  def name
    "#{I18n.t team_code, :scope => 'teams'}"
  end

  def message_team_name
    "#{Team.model_name.human} \"#{name}\""
  end
end
