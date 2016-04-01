module TeamsHelper

  def flag_image_tag(team_code, size: 16)
    if team_code.present?
      image_tag 'blank.gif', class: "flag flag-#{size} flag-#{team_code.downcase}"
    end
  end

  def team_collection_for_select
    Team.order_by_country_name_asc.collect { |team| [team.name, team.id] }
  end
end