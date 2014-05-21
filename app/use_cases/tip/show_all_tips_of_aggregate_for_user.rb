class ShowAllTipsOfAggregateForUser

  def initialize(tournament:, user_id:, current_aggregate_id: nil)
    @tournament = tournament
    @user_id = user_id
    @current_aggregate_id = current_aggregate_id
  end

  def run_with_presentable(presentable)

    match_ids = Match.all_match_ids_by_aggregate_id(current_aggregate.id)
    tips = Tip.all_by_user_id_and_match_ids_for_listing(user_id: user_id, match_ids: match_ids)

    presentable.current_aggregate = current_aggregate
    presentable.tips = tips
  end

  private

  attr_reader :tournament, :user_id, :current_aggregate_id

  def current_aggregate
    @current_aggregate ||= begin
      if current_aggregate_id.present?
        Aggregate.find(current_aggregate_id)
      else
        tournament.current_phase
      end
    end
  end
end