class ShowAllTipsOfAggregateForUser

  def initialize(tournament:, user_id:, current_aggregate_id: nil)
    @tournament = tournament
    @user_id = user_id
    @current_aggregate_id = current_aggregate_id
  end

  def run_with_presentable(presentable)

    matches = Match.all_matches_of_aggregate_for_listing(current_aggregate.id)
    tips = Tip.all_by_user_id_and_match_ids(user_id: user_id, match_ids: matches.map(&:id))

    presentable.current_aggregate = current_aggregate
    presentable.matches = matches
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