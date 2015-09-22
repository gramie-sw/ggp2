module TipQueries

  class << self

    # Returns all tips recursively for given user_id and aggregate_id.
    # Includes matches with team_1 and team_2.
    def all_eager_by_user_id_and_aggregate_id_ordered_by_position(user_id, aggregate_id, order: 'matches.id')
      aggregate = Aggregate.find(aggregate_id)
      aggregate_ids = aggregate.has_groups? ? aggregate.groups.pluck(:id) : aggregate_id

      Tip.
          includes(match: [:team_1, :team_2]).
          where('tips.user_id' => user_id, 'matches.aggregate_id' => aggregate_ids).
          order(order)
    end
  end
end