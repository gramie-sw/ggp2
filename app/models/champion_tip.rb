class ChampionTip < ActiveRecord::Base

  include ChampionTipRepository

  belongs_to :user
  belongs_to :team

  RESULTS = {incorrect: 0, correct: 1}

  validates :team, presence: true, on: :update

  def correct?
    result == RESULTS[:correct]
  end
end
