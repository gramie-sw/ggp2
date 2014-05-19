module ChampionTipRepository

  extend ActiveSupport::Concern

  included do
    scope :all_with_no_team, -> { where('champion_tips.team_id IS NULL') }
  end

  module ClassMethods

    #TODO rename this method
    def user_ids_with_no_champion_tip
      all_with_no_team.pluck(:user_id)
    end
  end
end