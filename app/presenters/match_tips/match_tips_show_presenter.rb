class MatchTipsShowPresenter

  attr_reader :match, :page

  def initialize(match:, current_user_id:, page: nil)
    @match = match
    @current_user_id = current_user_id
    @page = page
  end

  def tip_presenters
    @tip_presenters ||= begin
      paginated_ordered_players_for_a_match.map do |user|
        tip = user.tips.first
        tip.match = match
        TipPresenter.new(tip: tip, is_for_current_user: @current_user_id == user.id)
      end
    end
  end

  def paginated_ordered_players_for_a_match
    UserQueries.players_ordered_by_nickname_asc_for_a_match_paginated(match_id: match.id, page: page)
  end

  def match_presenter
    @match_presenter ||= MatchPresenter.new(match)
  end
end