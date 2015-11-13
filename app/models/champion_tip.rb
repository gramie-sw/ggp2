class ChampionTip < ActiveRecord::Base

  include ChampionTipRepository

  belongs_to :user
  belongs_to :team

  RESULTS = {incorrect: 0, correct: 1}

  # we must comment this out because we cannot set a result on ChampionTip without a Team
  # validates :team, presence: true, on: :update

  def correct?
    result == RESULTS[:correct]
  end
end
