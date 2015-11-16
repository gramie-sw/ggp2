class CalculateTipResults

  def run match_id
    match = Match.find(match_id)
    TipQueries.all_tipped_by_match_id(match_id).each do |tip|
      tip.set_result(match)
      tip.save
    end
  end
end