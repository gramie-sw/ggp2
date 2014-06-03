class TeamsIndexPresenter

  def initialize new_team=nil
    @new_team = new_team
  end

  def teams
    @teams ||= Team.order_by_country_name_asc
  end

  def new_team
    @new_team ||= Team.new
  end
end