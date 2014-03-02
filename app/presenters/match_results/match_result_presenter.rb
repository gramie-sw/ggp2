class MatchResultPresenter < DelegateClass(MatchResult)

  def match_presenter
    @match_presenter ||= MatchPresenter.new(__getobj__.match)
  end
end