class Property < ActiveRecord::Base

  TOURNAMENT_TITLE_KEY = 'tournament_title'
  CHAMPION_TITLE_KEY = 'champion_title'
  LAST_TIP_RANKING_SET_MATCH_ID_KEY = 'last_tip_ranking_set_match_id'
  CHAMPION_TIP_RANKING_SET_EXISTS_KEY = 'champion_tip_ranking_set_exists'
  TEAM_TYPE_KEY = 'team_type'

  validates :key, presence: true, uniqueness: true, length: {maximum: 64}
  validates :value, presence: true, length: {maximum: 128}

  class << self

    def set_last_tip_ranking_set_match_id_to match_id
      PropertyQueries.save_value(LAST_TIP_RANKING_SET_MATCH_ID_KEY, match_id)
    end

    def last_tip_ranking_set_match_id
      value = PropertyQueries.find_value(LAST_TIP_RANKING_SET_MATCH_ID_KEY).try(:to_i)
      value == 0 ? nil : value
    end

    def set_champion_tip_ranking_set_exists_to boolean
      PropertyQueries.save_value(CHAMPION_TIP_RANKING_SET_EXISTS_KEY, boolean)
    end

    def champion_tip_ranking_set_exists?
      PropertyQueries.find_value(CHAMPION_TIP_RANKING_SET_EXISTS_KEY) == '1'
    end

    def team_type
      PropertyQueries.find_value(TEAM_TYPE_KEY)
    end
  end
end
