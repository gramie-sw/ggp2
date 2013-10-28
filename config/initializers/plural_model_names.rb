class ActiveModel::Name

  def human_plural
    if I18n.locale == :en
      human.pluralize
    else
      human(count: 2)
    end
  end
end