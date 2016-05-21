class UserRankingDiagramPresenter

  attr_reader :user_id, :tournament

  def initialize(user_id, tournament)
    @user_id, @tournament = user_id, tournament
  end

  def diagram_data
    data = []

    if played_match_count == 0
      data = [1, player_count], [total_match_count, player_count]
    elsif played_match_count == 1
      data = diagram_data_provider.provide.unshift([0, player_count])
    elsif played_match_count > 1
      data = diagram_data_provider.provide
    end

    data.unshift(diagram_labels)
  end

  def h_axis_min_value
    played_match_count == 1 ? 0 : 1
  end

  def h_axis_max_value
    played_match_count == 1 ? 1 : total_match_count
  end

  def h_axis_ticks
    if played_match_count == 0
      [1, total_match_count]
    elsif played_match_count == 1
      [0, 1]
    elsif played_match_count > 1
      [1, played_match_count]
    end
  end

  def v_axis_min_value
    1
  end

  def v_axis_max_value
    player_count
  end

  def v_axis_ticks
    [1, player_count]
  end

  private

  def played_match_count
    @played_match_count ||= tournament.played_match_count
  end

  def total_match_count
    @total_match_count ||= tournament.total_match_count
  end

  def player_count
    @player_count ||= tournament.player_count
  end

  def diagram_data_provider
    @diagram_data_provider ||= UserMatchPositionHistoryDataProvider.new(user_id)
  end

  def diagram_labels
    @diagram_labels ||= [Match.human_attribute_name(:position), I18n.t('ranking.position')]
  end
end