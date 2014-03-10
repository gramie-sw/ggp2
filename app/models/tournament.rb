class Tournament

  def started?
    first_match.started?
  end

  def start_date

  end

  private

  def first_match
    @first_match ||= Match.order_by_position.first
  end
end