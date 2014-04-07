class RankingItem < ActiveRecord::Base

  include RankingItemRepository

  belongs_to :match
  belongs_to :user

  def ranking_hash
    "#{correct_champion_tip? ? 1 : 0}#{points}#{correct_tips_count}#{correct_tendency_tips_only_count}"
  end

  def self.neutral(user_id=nil)
    RankingItem.new(id: 0, user_id: user_id, position: 0, correct_tips_count: 0, correct_tendency_tips_only_count: 0, points: 0)
  end

end
