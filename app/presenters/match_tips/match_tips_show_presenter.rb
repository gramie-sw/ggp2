class MatchTipsShowPresenter

  attr_reader :match

  def initialize(match:, current_user_id:, page: nil)
    @match = match
    @current_user_id = current_user_id
    @page = page
  end

  def tip_presenters
    @tip_presenters ||= begin
      pagination_scope.map do |user|
        tip = user.tips.first
        tip.match = match
        TipPresenter.new(tip: tip, is_for_current_user: @current_user_id == user.id)
      end
    end
  end

  #TODO Severe Codesmell
  def pagination_scope
    User.
        players.order_by_nickname_asc.
        includes(:tips).where('tips.match_id = ?', @match.id).
        references(:tips).page(@page).per(Ggp2.config.user_page_count)
  end

  def match_presenter
    @match_presenter ||= MatchPresenter.new(match)
  end
end