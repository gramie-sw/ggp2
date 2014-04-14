module TeamsHelper

  # <b>DEPRECATED:</b> Please use <tt>standard_flag_image_tag</tt> instead.
  def standard_flag_image_tag_of team
    if team.present?
      image_tag 'blank.gif', class: "flag flag-#{team.country.downcase}"
    end
  end

  def standard_flag_image_tag country
    if country.present?
      image_tag 'blank.gif', class: "flag flag-#{country.downcase}"
    end
  end
end