class MatchResultPresenter < DelegateClass(MatchResult)

  attr_reader :match_result

  def initialize match_result
    super(match_result)
    @match_result = match_result
  end

  def match_presenter
    @match_presenter ||= MatchPresenter.new(__getobj__.match)
  end
end