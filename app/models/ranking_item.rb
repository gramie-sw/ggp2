class RankingItem < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  scope :ranking_items_by_match_id, ->(match_id) { where(match_id: match_id) }

  def self.exists_by_match_id? match_id
    ranking_items_by_match_id(match_id).exists?
  end

  def self.update_multiple match_id, ranking_items
    RankingItem.transaction do
      RankingItem.destroy_all(match_id: match_id)
      ranking_items.each(&:save!)
    end
  end

  def ranking_hash
    "#{points}#{correct_tips_count}#{correct_tendency_tips_only_count}"
  end

  def self.neutral
    RankingItem.new(id: 0, position: 0, correct_tips_count: 0, correct_tendency_tips_only_count: 0, points: 0)
  end

end
