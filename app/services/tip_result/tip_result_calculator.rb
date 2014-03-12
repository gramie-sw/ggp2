class TipResultCalculator

  def initialize(tip:, match:)
    @tip = tip
    @match = match
  end

  def result
    if correct_tip?
      Tip::RESULTS[:correct]
    elsif  correct_tendency?
      Tip::RESULTS[:correct_tendency]
    else
      Tip::RESULTS[:incorrect]
    end
  end

  private

  def correct_tip?
    @tip.score_team_1 == @match.score_team_1 and @tip.score_team_2 == @match.score_team_2
  end

  def correct_tendency?
    ((@tip.score_team_1 - @tip.score_team_2) <=> 0) == ((@match.score_team_1 - @match.score_team_2) <=> 0)
  end
end