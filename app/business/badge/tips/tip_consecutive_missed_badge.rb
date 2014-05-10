class TipConsecutiveMissedBadge < Badge

  attr_accessor :count

  def initialize attributes={}
    attributes.each { |key, value| send("#{key}=", value)}
  end

  def eligible_user_ids

  end

  def identifier
    "#{self.class.name.underscore}_#{count}".to_sym
  end
end