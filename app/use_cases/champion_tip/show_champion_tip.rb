class ShowChampionTip

  def initialize(user_id)
    @user_id = user_id
  end

  def run_with_presentable(presentable)
    presentable.champion_tip = ChampionTip.find_by_user_id(user_id)
  end

  private

  attr_reader :user_id
end