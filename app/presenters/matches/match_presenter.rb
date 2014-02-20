class MatchPresenter < DelegateClass(Match)

  include ResultPresentable

  def team_1_name_or_placeholder
    team_name_or_placeholder_of_team 1
  end

  def team_2_name_or_placeholder
    team_name_or_placeholder_of_team 2
  end

  private

  def team_name_or_placeholder_of_team team_number
    send("team_#{team_number}").try(:name) || send("placeholder_team_#{team_number}")
  end
end