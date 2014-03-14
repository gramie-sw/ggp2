class RankingItem < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  scope :ranking_items, ->(match_id= nil) { where(match_id: match_id)}

end
