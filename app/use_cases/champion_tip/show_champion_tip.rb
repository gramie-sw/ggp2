class ShowChampionTip

  def run_with_presentable(presentable, user_id)

    presentable.champion_tip = ChampionTip.find_by_user_id(user_id)
  end
end