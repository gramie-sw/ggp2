module LegacyTipResultCalculator
  extend self

  def result(tip:, match:)
    if correct? tip: tip, match: match
      Tip::RESULTS[:correct]
    elsif  correct_tendency? tip: tip, match: match
      Tip::RESULTS[:correct_tendency_only]
    else
      Tip::RESULTS[:incorrect]
    end
  end

  def correct?(tip:, match:)
    tip.score_team_1 == match.score_team_1 and tip.score_team_2 == match.score_team_2
  end

  def correct_tendency?(tip:, match:)
    ((tip.score_team_1 - tip.score_team_2) <=> 0) == ((match.score_team_1 - match.score_team_2) <=> 0)
  end
end