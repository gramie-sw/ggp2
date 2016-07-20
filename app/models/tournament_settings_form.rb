class TournamentSettingsForm
  include ActiveModel::Model
  include Virtus.model

  validates :tournament_title, presence: true, length: {minimum: 5, maximum: 32}
  validates :champion_title, presence: true, length: {minimum: 5, maximum: 32}
  validates :team_type, inclusion: Team::TYPES

  attribute :tournament_title, String
  attribute :champion_title, String
  attribute :team_type, String

  def tournament_title
    @tournament_title ||= PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY)
  end

  def champion_title
    @champion_title ||= PropertyQueries.find_value(Property::CHAMPION_TITLE_KEY)
  end

  def team_type
    @team_type ||= PropertyQueries.find_value(Property::TEAM_TYPE_KEY)
  end

  def persisted?
    true
  end
end