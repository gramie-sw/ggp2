module MatchRepository

  def self.extended base
    base.class_eval do
      scope :all_following_matches_by_position, ->(position) { where 'position > ?', position }
      scope :all_previous_matches_by_position, ->(position) { where 'position < ?', position }
      scope :all_with_result, -> { where('score_team_1 IS NOT NULL AND score_team_2 IS NOT NULL') }
      scope :count_all_with_results, -> { all_with_result.count }
      scope :future_matches, -> { where('matches.date > ?', Time.now) }
      scope :order_by_position_asc, -> { order(position: :asc) }
      scope :order_by_date_asc, -> { order(date: :asc) }
    end
  end

  def first_match
    order_by_position_asc.first
  end

  def last_match
    order_by_position_asc.last
  end

  def next_match
    order_by_date_asc.where('date >= ? ', Time.now).first
  end

  def all_matches_of_aggregate_for_listing(aggregate_id)
    recursive_match_relation_by_aggregate_id(aggregate_id).order_by_position_asc.includes(:team_1, :team_2)
  end

  private

  def recursive_match_relation_by_aggregate_id(aggregate_id)
    aggregate = Aggregate.find(aggregate_id)
    if aggregate.phase? && aggregate.has_groups?
      Match.where(aggregate_id: aggregate.children).references(:aggregates)
    else
      aggregate.matches
    end
  end
end