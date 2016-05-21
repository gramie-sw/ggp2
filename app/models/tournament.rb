class Tournament

  def title
    @tournament_title ||= PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY)
  end

  def champion_title
    @champion_title ||= PropertyQueries.find_value(Property::CHAMPION_TITLE_KEY)
  end

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
    @played_match_count ||= MatchQueries.count_all_with_results
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
    @current_phase ||= begin
      if next_match.present?
        next_match.phase
      else
        last_match.phase
      end
    end
  end

  def player_count
    @player_count ||= UserQueries.player_count
  end

  def highest_match_position_with_result
    @highest_match_position_with_result ||= MatchQueries.highest_match_position_with_result
  end

  private

  def first_match
    @first_match ||= MatchQueries.first_match
  end

  def last_match
    @last_match ||= MatchQueries.last_match
  end

  def next_match
    @next_match ||= MatchQueries.next_match
  end
end