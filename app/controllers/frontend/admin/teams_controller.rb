module Frontend
  module Admin
    class TeamsController < ApplicationController

      def index
        @teams = Team.order_by_team_name_asc
        render json: @teams
      end
    end
  end
end