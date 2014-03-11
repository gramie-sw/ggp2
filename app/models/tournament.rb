class Tournament

  def started?
    first_match.present? && first_match.started?
  end

  def start_date
    first_match.try(:date)
  end

  alias champion_tip_deadline start_date

  def champion_tippable?
    !started?
  end

  private

  def first_match
    @first_match ||= Match.order_by_position.first
  end
end