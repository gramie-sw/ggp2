module Admin
  class AvailableTeamsController < ApplicationController

    def index
      @teams = AvailableTeamQueries.all_ordered_by_name
      render json: @teams
    end
  end
end