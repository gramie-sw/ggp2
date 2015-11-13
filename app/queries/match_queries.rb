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
  end
end