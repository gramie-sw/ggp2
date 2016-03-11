module TeamsHelper

  # <b>DEPRECATED:</b> Please use <tt>standard_flag_image_tag</tt> instead.
  def standard_flag_image_tag_of team
    if team.present?
      image_tag 'blank.gif', class: "flag-16 flag-#{team.country.downcase}"
    end
  end

  def standard_flag_image_tag team_abbreviation
    if team_abbreviation.present?
      image_tag 'blank.gif', class: "flag-16 flag-#{team_abbreviation.downcase}"
    end
  end

  def flag_image_tag(team_abbreviation, size: 16)
    if team_abbreviation.present?
      image_tag 'blank.gif', class: "flag flag-#{size} flag-#{team_abbreviation.downcase}"
    end
  end

  def team_collection_for_select
    Team.order_by_country_name_asc.collect { |team| [team.name, team.id] }
  end
end