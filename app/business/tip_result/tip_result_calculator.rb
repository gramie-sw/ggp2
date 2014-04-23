module TipResultCalculator
  extend self

  def calculate(match, tip)
    if TipResult.correct?(match, tip)
      Tip::RESULTS[:correct]
    elsif  TipResult.correct_tendency?(match, tip)
      Tip::RESULTS[:correct_tendency_only]
    else
      Tip::RESULTS[:incorrect]
    end
  end
end