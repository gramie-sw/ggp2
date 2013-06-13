class TechnicalNameAllowedCharsValidator < ActiveModel::EachValidator

  ALLOWED_CHARS = "test123 /()[]\\"

  def validate_each(object, attribute, value)
    unless value =~ /\A[\w\d \-\/()\[\]=\\äöüÄÖÜß]+\z/i
      object.errors[attribute] << (options[:message] || I18n.t('errors.messages.not_allowed_chars'))
    end
  end
end


