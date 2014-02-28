class TipsEditMultiplePresenter

  def initialize tip_ids: nil, tips: nil
    raise "Only tips_ids or tips must be given, not both" if tip_ids.nil? && tips.nil?
    @tip_ids = tip_ids unless tip_ids.nil?
    @tip_presenters = wrap_in_tip_presenters(tips) unless tips.nil?
  end

  def tip_presenters
    @tip_presenters ||= begin
      wrap_in_tip_presenters(Tip.where(id: @tip_ids).includes(:match).order_by_match_position)
    end
  end

  private

  def wrap_in_tip_presenters tips
    tips.map { |t| TipPresenter.new(tip: t, is_for_current_user: true) }
  end
end