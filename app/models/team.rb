class Team < ActiveRecord::Base

  has_many :team_1_matches, :class_name => "Match", :foreign_key => "team_1_id"
  has_many :team_2_matches, :class_name => "Match", :foreign_key => "team_2_id"

  validates :country, presence: true, uniqueness: true, length: {maximum: 2}

  scope :order_by_country_name, -> { all.sort_by { |team| I18n.t(team.country, :scope => 'countries')}}

  before_destroy :before_destroy

  def before_destroy
    unless team_1_matches.empty? && team_2_matches.empty?
      errors.add :base, I18n.t('errors.messages.team_to_delete_is_associated_to_games')
      false
    end
  end

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
