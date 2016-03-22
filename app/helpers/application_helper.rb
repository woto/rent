module ApplicationHelper

  def page_header
    content_tag :div, class: 'page-header' do
      yield
    end
  end

  def icon(icon, css_class='')
    content_tag :i, '', class: ["fa", "fa-#{icon}", css_class].join(' ')
  end

  def currency(amount)
    number_to_currency(amount, precision: 0).gsub(' ', '&nbsp;').html_safe
  end

  def area_date_end_in_future_contracts(area)
    capture do
      area.contracts.date_end_in_future.each do |contract|
        concat link_to(contract.to_label, contract_path(contract))
        concat "<br />".html_safe
      end
    end
  end

  def renter_actual_contracts(renter)
    capture do
      renter.contracts.date_end_in_future.each do |contract|
        concat link_to(contract.to_label, contract_path(contract))
        concat "<br />".html_safe
      end
    end
  end

  def ransack_search &block
    content_tag :div, class: 'row' do
      content_tag :div, class: 'col-md-7' do
        content_tag :div, class: 'card' do
          concat(content_tag(:div, class: 'card-header') do
            concat("Поиск")
            concat(content_tag(:button, class: 'btn btn-secondary btn-sm pull-right',
                   type: 'button', data: {toggle: 'collapse', target: '#ransack-search'}) do
              icon 'caret-down'
            end)
          end)
          concat(content_tag(:div, class: "card-block collapse #{ransack_params.present? ? 'in' : ''}", id: 'ransack-search') do
            yield
          end)
        end
      end
    end
  end

end
