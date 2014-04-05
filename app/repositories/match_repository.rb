module MatchRepository

  def self.extended base
    base.class_eval do
      scope :order_by_position, -> { order('position ASC') }
      scope :all_following_matches_by_position, ->(position) { where 'position > ?', position }
      scope :all_previous_matches_by_position, ->(position) { where 'position < ?', position }
      scope :future_matches, -> { where('matches.date > ?', Time.now) }
      scope :only_with_result, -> { where('score_team_1 IS NOT NULL AND score_team_2 IS NOT NULL') }
    end
  end

  def first_match
    Match.order_by_position.first
  end

  def last_match
    Match.order_by_position.last
  end
end