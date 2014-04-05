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

  def played_match_count
    @match ||= Match.only_with_result.count
  end

  def champion_team
    @champion_team ||= last_match.winner_team
  end

  private

  def first_match
    @first_match ||= Match.first_match
  end

  def last_match
    @last_match ||= Match.last_match
  end

end