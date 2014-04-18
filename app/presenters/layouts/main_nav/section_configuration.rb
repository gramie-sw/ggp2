class SectionConfiguration

  attr_accessor :name, :controller
  attr_reader :actions

  def initialize name=nil
    @name = name
  end
  
end