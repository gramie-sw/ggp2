class TipPresenter < DelegateClass(Tip)

  include ResultPresentable

  attr_reader :tip

  def initialize(tip)
    super(tip)
    @tip = tip
  end

  def match_presenter
    @match_presenter ||= MatchPresenter.new(tip.match)
  end
end