class TipPresenter < DelegateClass(Tip)

  include ResultPresentable

  attr_reader :is_for_current_user

  def initialize(tip:, is_for_current_user:)
    super(tip)
    @is_for_current_user = is_for_current_user
  end

  def points
    # TODO we must use __getobj__ because result is accidentally overriden by ResultPresentable
    __getobj__.result.present? ? super : '-'
  end

  def hide_existing_result?
    !@is_for_current_user && tippable?
  end

  def match_presenter
    @match_presenter ||= MatchPresenter.new(match)
  end
end