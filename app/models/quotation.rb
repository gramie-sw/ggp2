class Quotation
  attr_accessor :author, :content

  def initialize attributes={}
    attributes.each { |name, value| send("#{name}=", value) }
  end
end