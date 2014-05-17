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
    @played_match_count ||= Match.count_all_with_results
  end

  def total_match_count
    @total_match_count ||= Match.count
  end

  def champion_team
    @champion_team ||= last_match.winner_team
  end

  def finished?
    last_match.has_result?
  end

  def current_phase
    @current_phase ||= next_match.phase
  end

  private

  def first_match
    @first_match ||= Match.first_match
  end

  def last_match
    @last_match ||= Match.last_match
  end

  def next_match
    @next_match ||= Match.next_match
  end
end