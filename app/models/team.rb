class Team < ActiveRecord::Base

  has_many :team_1_matches, class_name: :Match, foreign_key: :team_1_id, dependent: :restrict_with_exception
  has_many :team_2_matches, class_name: :Match, foreign_key: :team_2_id, dependent: :restrict_with_exception
  has_many :champion_tips, dependent: :nullify

  validates :country, presence: true, uniqueness: true, length: {maximum: 2}

  scope :order_by_country_name_asc, -> { all.sort_by { |team| I18n.t(team.country, :scope => 'countries') } }

  def abbreviation
    country
  end

  def name
    "#{I18n.t country, :scope => 'countries'}"
  end

  def message_country_name
    "#{Team.model_name.human} \"#{name}\""
  end
end
