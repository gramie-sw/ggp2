module ProfilesHelper

  def show_menu_li_attributes section, current_section
    if section == current_section
      {class: :active}
    else
      {}
    end
  end

end