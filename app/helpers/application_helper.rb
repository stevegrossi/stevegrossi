module ApplicationHelper

  def markdown(text)
    return if text.blank?
    Maruku.new(text).to_html.html_safe
  end

  def strip_markdown(text)
    strip_tags(markdown(text))
  end

  def link_to_new(class_name)
    link_to "New #{class_name}", new_polymorphic_path([:meta, class_name])
  end

  def link_to_edit(thing)
    link_to "Edit", polymorphic_path([:meta, thing], action: :edit)
  end

  def link_to_delete(thing)
    name = thing.class.name.titleize
    link_to "Delete this #{name}", polymorphic_path([:meta, thing]), data: { confirm: "Are you sure you want to delete this #{name}? This cannot be undone." }, method: :delete, class: 'delete_link'
  end

  def nav_link_to(text, target, options = {})
    options[:class] = ['SiteHeader-navLink']
    path = Rails.application.routes.recognize_path(target)
    if current_page?(target) || (controller_path != 'pages' && path[:controller] == controller_path)
      options[:class] << 'SiteHeader-navLink--current'
    end
    link_to(text, target, options)
  end

  def nice_url(url)
    url.gsub(/(^https?:\/\/(www.)?)|(\/$)/, '') if url
  end

  def link_from_url(url)
    link_to(nice_url(url), url)
  end

  def flash_errors(obj)
    if obj.errors.present?
      content_tag :div, class: 'Flash Flash--error' do
        "Could not save the #{obj.class.to_s.humanize.downcase} because of the errors below:"
      end
    end
  end

  def mark_string(string, term = '')
    if term.blank?
      string
    else
      raw string.gsub(/#{Regexp.escape(term).gsub(/\\\s/, '|')}/i, '<mark>\0</mark>')
    end
  end

  def serp_excerpt(text)
    strip_markdown(text).gsub(/\{\{|\}\}/, '{{' => '<mark>', '}}' => '</mark>').html_safe
  end

  def comment_on_search_term(query)
    unless query.blank?
      case query.downcase
      when 'shit', 'fuck', 'cunt', 'cocksucker', 'motherfucker'
        content_tag(:p, content_tag(:em, 'You kiss your mother with that mouth?'))
      end
    end
  end

  def notify(action, class_name)
    view_all_link = link_to('View all', polymorphic_path("meta_#{class_name}s"))
    case action
    when :new
      message = "New #{class_name} created."
    when :updated
      message = "Updated #{class_name}."
    else
      raise ArgumentError, 'Actions supported: :new and :updated'
    end
    "#{message} #{view_all_link}."
  end
end
