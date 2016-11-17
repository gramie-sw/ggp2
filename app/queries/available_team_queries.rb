module AvailableTeamQueries

  class << self

    def all_ordered_by_name
      team_type = Property.team_type
      I18n.t(team_type).sort_by { |code, name| name.parameterize }.map do |code, name|
        AvailableTeam.new(id: code, name: name)
      end
    end
  end
end