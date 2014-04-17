class NavLink

  attr_accessor :label, :url, :active, :icon
  alias :active? :active

  def initialize attributes={}
    attributes.each { |attribute, value| send("#{attribute}=", value) }
  end

end