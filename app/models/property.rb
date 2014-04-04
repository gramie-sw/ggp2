class Property < ActiveRecord::Base

  extend PropertyRepository

  LAST_TIP_RANKING_SET_MATCH_ID_KEY = 'last_tip_ranking_set_match_id'
  CHAMPION_TIP_RANKING_SET_EXISTS_KEY = 'champion_tip_ranking_set_exists'

  validates :key, presence: true, uniqueness: true, length: {maximum: 64}
  validates :value, presence: true, length: {maximum: 128}

  def self.set_last_tip_ranking_set_match_id_to match_id
    Property.save_value(match_id, LAST_TIP_RANKING_SET_MATCH_ID_KEY)
  end

  def self.last_tip_ranking_set_match_id
    Property.find_value(LAST_TIP_RANKING_SET_MATCH_ID_KEY).try(:to_i)
  end

  def self.set_champion_tip_ranking_set_exists_to boolean
    Property.save_value(boolean, CHAMPION_TIP_RANKING_SET_EXISTS_KEY)
  end

  def self.champion_tip_ranking_set_exists?
    Property.find_value(CHAMPION_TIP_RANKING_SET_EXISTS_KEY) == 'true'
  end
end
