module TipsResultSetter
  extend self

  def set_results(match, tips)
    tips.each do |tip|
      tip.result = TipResultCalculator.calculate(match, tip)
    end
  end
end