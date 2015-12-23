class Badge
  include Virtus.model

  attribute :icon, String
  attribute :achievement, Integer
  attribute :color, String
  attribute :score, Integer

  def group_identifier additional_elements = []
    additional_elements = [additional_elements] unless additional_elements.is_a?(Array)
    class_name = self.class.name.underscore

    additional_elements.empty? ? class_name : class_name << '#' << additional_elements.join('#')
  end

  def identifier
    group_identifier << '#' << color
  end
end