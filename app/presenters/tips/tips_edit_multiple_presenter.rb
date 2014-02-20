class TipsEditMultiplePresenter

  def initialize tip_ids
    @tip_ids = tip_ids
  end

  def tip_presenters
    @tip_presenters ||= begin
      Tip.where(id: @tip_ids).includes(:match).order_by_match_position.map { |t| TipPresenter.new(t) }
    end
  end
end