class MatchPresenter < DelegateClass(Match)

  attr_reader :match

  def initialize(match)
    super(match)
    @match = match
  end

  def position
    "#{match.position}."
  end

  def team_1_name_or_placeholder
    team_name_or_placeholder_of_team 1
  end

  def team_2_name_or_placeholder
    team_name_or_placeholder_of_team 2
  end

  def result
    if match.has_result?
      "#{match.score_team_1} : #{match.score_team_2}"
    else
      '- : -'
    end
  end

  private

  def team_name_or_placeholder_of_team team_number
    match.send("team_#{team_number}").try(:name) || match.send("placeholder_team_#{team_number}")
  end
end