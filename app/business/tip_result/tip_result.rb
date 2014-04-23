module TipResult
  extend self

  def correct?(match, tip)
    tip.score_team_1 == match.score_team_1 and tip.score_team_2 == match.score_team_2
  end

  def correct_tendency?(match, tip)
    ((tip.score_team_1 - tip.score_team_2) <=> 0) == ((match.score_team_1 - match.score_team_2) <=> 0)
  end
end