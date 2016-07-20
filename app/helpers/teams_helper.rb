module TeamsHelper

  def flag_image_tag(team_code, size: 16)
    if team_code.present?
      if team_code.start_with?('CLUB_')
        content_tag(:i, '',  class: "club-logo club-logo-#{size} fa fa-soccer-ball-o")
      else
        image_tag 'blank.gif', class: "flag flag-#{size} flag-#{team_code.downcase}"
      end
    end
  end

  def tournament_teams_collection_for_select
    Team.order_by_team_name_asc.collect { |team| [team.name, team.id] }
  end

  def available_teams_collection_for_select
    team_type = Property.team_type
    t(team_type).sort_by { |code, name| name.parameterize }.map { |code, name| [name, code] }
  end

  def team_type_select_options
    Team::TYPES.map { |type| [t("team.type.#{type}"), type] }
  end
end