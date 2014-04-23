class LegacyTipResultService

  def initialize(match_id:)
    @match_id = match_id
  end

  def update_tips_with_result
    save_tips(tips_with_result)
  end

  private

  def tips_with_result
    tips = Tip.all_by_match_id(@match_id).tipped
    match = Match.find(@match_id)

    tips.each do |tip|
      tip.result = LegacyTipResultCalculator.result tip: tip, match: match
    end
  end

  def save_tips tips
    Tip.transaction do
      tips.each(&:save!)
    end
  end
end