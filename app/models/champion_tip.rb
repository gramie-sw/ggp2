class ChampionTip < ActiveRecord::Base

  include ChampionTipRepository

  belongs_to :user
  belongs_to :team

  RESULTS = {incorrect: 0, correct: 1}

  validates :team, presence: true, on: :update
  validate :team_not_changeable_after_tournament_started, on: :update


  def correct?
    result == RESULTS[:correct]
  end

  def team_not_changeable_after_tournament_started
    if Tournament.new.started?
      errors[:base] << I18n.t('errors.messages.champion_tip_changeable_after_tournament_started')
    end
  end
end
