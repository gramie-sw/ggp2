class RankingItem < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  def self.neutral
    RankingItem.new position: 0, correct_tips_count: 0, correct_tendency_tips_only_count: 0, points: 0
  end
end
