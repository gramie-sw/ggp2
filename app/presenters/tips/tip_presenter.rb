class TipPresenter < DelegateClass(Tip)

  include ResultPresentable

  def initialize(tip:, is_for_current_user:)
    super(tip)
    @is_for_current_user = is_for_current_user
  end

  def points
    super || '-'
  end

  def match_presenter
    @match_presenter ||= MatchPresenter.new(match)
  end

  private

  def display_protected_tip_attributes?
    @is_for_current_user || !tippable?
  end
end