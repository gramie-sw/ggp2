module ApplicationHelper

  #TODO test over feature spec
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
      <div class="alert alert-error alert-block">
        <button type="button" class="close" data-dismiss="alert">&#215;</button>
        #{messages}
      </div>
    HTML
    html.html_safe
  end

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
