module TournamentSettings
  class Update < UseCase

    attribute :tournament_settings_attributes

    def run
      tournament_settings_form = TournamentSettingsForm.new(tournament_settings_attributes)

      if tournament_settings_form.valid?
        PropertyQueries.save_value(Property::TOURNAMENT_TITLE_KEY,
                                   tournament_settings_form.tournament_title)
        PropertyQueries.save_value(Property::CHAMPION_TITLE_KEY,
                                   tournament_settings_form.champion_title)
      end

      tournament_settings_form
    end
  end
end