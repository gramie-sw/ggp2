class TournamentSettingsForm
  include ActiveModel::Model
  include Virtus.model

  validates :tournament_title, presence: true, length: { minimum: 5, maximum: 32}
  validates :champion_title, presence: true, length: { minimum: 5, maximum: 32}

  attribute :tournament_title, String
  attribute :champion_title, String

  def tournament_title
    @tournament_title ||= PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY)
  end

  def champion_title
    @champion_title ||= PropertyQueries.find_value(Property::CHAMPION_TITLE_KEY)
  end

  def persisted?
    true
  end
end