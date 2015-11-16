class NavLink

  attr_accessor :label, :url, :active, :icon, :params, :is_active_for

  def initialize attributes={}
    attributes.each { |attribute, value| send("#{attribute}=", value) }
  end

  def active?
    is_active_for.all? do |key, values|
      Array(values).any? { |value| params[key] == value.to_s }
    end
  end
end