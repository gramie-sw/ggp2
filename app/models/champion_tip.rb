class ChampionTip < ActiveRecord::Base

  include ChampionTipRepository

  belongs_to :user
  belongs_to :team

  RESULTS = {incorrect: 0, correct: 1}

  validates :team, presence: true, on: :update

  def correct?
    result == RESULTS[:correct]
  end

  def set_result champion_team_id
    if team_id == champion_team_id
      self.result = ChampionTip::RESULTS[:correct]
    else
      self.result = ChampionTip::RESULTS[:incorrect]
    end
  end
end
