class UserTipsShowPresenter

  def initialize user_id:
      @user_id = user_id
  end

  def phases
    Aggregate.phases.order_by_position
  end

  def match_presenters_of(phase)
    phase.matches_including_of_children.order_by_position.collect { |m| MatchPresenter.new m }
  end
end