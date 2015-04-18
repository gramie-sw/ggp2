module MatchQueries

  def all_by_aggregate_id_ordered(aggregate_id, order:, includes: nil)
    aggregate = Aggregate.find(aggregate_id)
    if aggregate.has_groups?
      relation = Match.where(aggregate_id: aggregate.groups.pluck(:id))
    else
      relation = Match.where(aggregate_id: aggregate_id)
    end

    relation = relation.includes(*Array(includes)) if includes.present?
    relation.order(order)
  end
end