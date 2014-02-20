class TipPresenter < DelegateClass(Tip)

  include ResultPresentable

  def match_presenter
    @match_presenter ||= MatchPresenter.new(match)
  end
end