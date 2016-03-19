module ApplicationHelper

  def page_header
    content_tag :div, class: 'page-header' do
      yield
    end
  end

  def icon(icon, css_class='')
    content_tag :i, '', class: ["fa", "fa-#{icon}", css_class].join(' ')
  end

end
