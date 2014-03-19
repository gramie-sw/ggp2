class RankingItem < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  scope :by_match_id, ->(match_id= nil) { where(match_id: match_id)}
end
