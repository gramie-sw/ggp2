class TournamentSettingsPresenter

  def team_index_presenter
    @team_index_presenter ||= TeamsIndexPresenter.new
  end
end