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

  def area_actual_contracts(area)
    capture do
      area.contracts.actual.each do |contract|
        concat link_to(contract.to_label, contract_path(contract))
        concat "<br />".html_safe
      end
    end
  end

  def renter_actual_contracts(renter)
    capture do
      renter.contracts.actual.each do |contract|
        concat link_to(contract.to_label, contract_path(contract))
        concat "<br />".html_safe
      end
    end
  end

end
