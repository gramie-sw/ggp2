module MatchesHelper

  def standard_flag_image_tag_of team
    if team.present?
      image_tag 'blank.gif', class: "flag flag-#{team.country.downcase}" if team.present?
    end
  end
end