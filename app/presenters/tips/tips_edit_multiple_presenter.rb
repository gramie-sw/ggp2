class TipsEditMultiplePresenter

  def initialize tip_ids
    @tip_ids = tip_ids
  end

  def tip_presenters
    @tip_presenters || begin
      Tip.where(id: @tip_ids).includes(:matches)
    end
  end
end