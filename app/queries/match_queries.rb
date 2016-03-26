module MatchQueries

  class << self

    def all_by_aggregate_id(aggregate_id, order:, includes: nil)
      aggregate = Aggregate.find(aggregate_id)
      aggregate_ids = aggregate.has_groups? ? aggregate.groups.pluck(:id) : aggregate_id
      relation = Match.where(aggregate_id: aggregate_ids)
      relation = relation.includes(*Array(includes)) if includes.present?
      relation.order(order)
    end

    def all_match_ids_ordered_by_position
      Match.order(:position).pluck(:id)
    end

    def matches_with_aggregates aggregates
      Match.where(aggregate_id: aggregates).references(:aggregates)
    end

    def count_all_with_results
      Match.where('score_team_1 IS NOT NULL AND score_team_2 IS NOT NULL').count
    end

    def first_match
      order_by_position_asc.first
    end

    def future_matches
      Match.where('matches.date > ?', Time.now)
    end

    def last_match
      order_by_position_asc.last
    end

    def next_match
      order_by_date_asc.where('date >= ? ', Time.now).first
    end

    def order_by_date_asc
      Match.order(date: :asc)
    end

    def order_by_position_asc
      Match.order(position: :asc)
    end
  end
end