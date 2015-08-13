module TournamentSettings
  class CreateForm < UseCase

    def run

      tournament_settings_attributes = {
          tournament_title: PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY),
          champion_title: PropertyQueries.find_value(Property::CHAMPION_TITLE_KEY),
      }

      TournamentSettingsForm.new (tournament_settings_attributes)
    end
  end
end