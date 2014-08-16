class FindChampionTip

  def initialize(user_id)
    @user_id = user_id
  end

  def run
    ChampionTip.find_by_user_id(user_id)
  end

  private

  attr_reader :user_id
end