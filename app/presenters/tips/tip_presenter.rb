class TipPresenter < DelegateClass(Tip)

  attr_reader :tip

  def initialize(tip)
    super(tip)
    @tip = tip
  end

  def match_presenter
    @match_presenter ||= begin
      MatchPresenter.new(tip.match)
    end
  end
end