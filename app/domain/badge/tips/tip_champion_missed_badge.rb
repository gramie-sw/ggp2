class TipChampionMissedBadge < Badge

  def initialize attributes={}
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def eligible_user_ids
    Tournament.new.started? ? ChampionTip.user_ids_with_no_champion_tip : []
  end
end