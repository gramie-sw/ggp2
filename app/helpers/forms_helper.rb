module FormsHelper

  def display_base_errors resource
    display_attribute_errors(resource, attribute: :base)
  end

  def display_attribute_errors(resource, attribute:)
    messages = resource.errors[attribute].map do |msg|
      "#{resource.class.human_attribute_name(attribute)} #{msg}"
    end
    display_error_messages(messages)
  end

  private

  def display_error_messages messages
    unless messages.blank?
      html = <<-HTML
      <div class="alert alert-danger">
        <button type="button" class="close" data-dismiss="alert">&#215;</button>
        <div>
          <ul>
      HTML

      messages.each do |message|
        html += "<li>#{message}</li>"
      end

      html += "</div></ul></div>"
      html.html_safe
    end
  end
end
