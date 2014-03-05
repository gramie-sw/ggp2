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

  def main_navbar_link(title, path, active_key)
    content_tag('li', class: main_navbar_link_active?(active_key) ? 'active' : '') do
      link_to title, path
    end
  end

  def main_navbar_link_active?(active_key)
    controller = params[:controller]
    if active_key == :aggregates
      controller == 'aggregates'
    elsif active_key == :matches
      controller == 'matches'
    elsif active_key == :venues
      controller == 'venues'
    elsif active_key == :users
      controller == 'users'
    elsif false
    end
  end
end
