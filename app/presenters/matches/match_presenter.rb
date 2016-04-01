class MatchPresenter < DelegateClass(Match)

  include ResultPresentable

  def team_1_code
    team_1.try(:country)
  end

  def team_2_code
    team_2.try(:country)
  end

  def team_1_name_or_placeholder
    team_name_or_placeholder_of_team 1
  end

  def team_2_name_or_placeholder
    team_name_or_placeholder_of_team 2
  end

  def aggregate_name_recursive multiline: false
    @aggregate_name_recursive ||= begin

      if aggregate.phase?
        [aggregate.name]
      else
        [aggregate.parent.name, aggregate.name]
      end
    end

    if multiline
      @aggregate_name_recursive
    else
      if @aggregate_name_recursive.size == 1
        @aggregate_name_recursive.first
      else
        "#{@aggregate_name_recursive.first} - #{@aggregate_name_recursive.second}"
      end
    end
  end

  private

  def team_name_or_placeholder_of_team team_number
    send("team_#{team_number}").try(:name) || send("placeholder_team_#{team_number}")
  end
end