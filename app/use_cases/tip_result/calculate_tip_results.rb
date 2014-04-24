class CalculateTipResults

  def run match_id
    match = Match.find_by(id: match_id)
    tips = Tip.all_by_match_id(match_id).tipped
    TipsResultSetter.set_results(match, tips)
    Tip.update_multiple_tips(tips)
  end
end