class MatchTipsShowPresenter

  attr_reader :match

  def initialize(match:, current_user_id:)
    @match = match
    @current_user_id = current_user_id
  end

  def test

  end

  def tip_presenters
    @tip_presenters ||= begin
      User.players.order_by_nickname_asc.includes(:tips).where('tips.match_id = ?', @match.id).references(:tips).map do |user|
        TipPresenter.new(tip: user.tips.first, is_for_current_user: @current_user_id == user.id)
      end
    end
  end

  def match_presenter
    @match_presenter ||= MatchPresenter.new(match)
  end

end