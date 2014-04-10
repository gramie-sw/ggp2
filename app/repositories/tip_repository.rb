module TipRepository

  def self.extended(base)
    base.class_eval do
      base.scope :all_by_match_id, ->(match_id) { where(match_id: match_id) }
      scope :order_by_match_position, -> { joins(:match).order('matches.position').references(:matches) }
      scope :tipped, -> { where("score_team_1 IS NOT NULL AND score_team_2 IS NOT NULL")}
    end
  end
end