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

  #links
  def add_link(path, text=t('general.add'), icon='fa fa-plus', only_icon: false,  html_options: {})
    icon_link path, text, icon, only_icon, html_options: html_options
  end

  def back_link(path, text=t('general.back'), icon='fa fa-arrow-circle-o-left', only_icon: false, html_options: {})
    icon_link path, text, icon, only_icon, html_options: html_options
  end

  def edit_link(path, text=t('general.edit'), icon='fa fa-pencil', only_icon: false, html_options:{})
    icon_link path, text, icon, only_icon, html_options: html_options
  end

  def destroy_link(path, text=t('general.destroy'), icon='fa fa-trash-o', only_icon: false, confirm: confirm, html_options: {})
    icon_link path, text, icon, only_icon, html_options: {method: :delete, data: {confirm: confirm}}.merge(html_options)
  end

  def icon_link(path, text, icon, only_icon, html_options: {})
    link_to(path, html_options) do
      "<i class=\"#{icon}\", title=\"#{text}\")}></i>#{only_icon ? '' :  " "  + text}".html_safe
    end
  end
end
