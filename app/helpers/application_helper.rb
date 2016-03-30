module ApplicationHelper

  def boolean_translation value
    if value.is_a? TrueClass
      I18n.t('general.yes')
    elsif value.is_a? FalseClass
      I18n.t('general.no')
    else
      value
    end
  end
end
