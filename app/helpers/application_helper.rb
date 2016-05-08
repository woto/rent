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
    content_tag :div, class: 'text-sm m-b-1' do
      area.contracts.date_end_in_future.each do |contract|
        concat(content_tag(:p, class: 'm-b-0') do
          link_to(contract.to_label, contract_path(contract))
        end)
      end
      if(area.today_contracts_rate > 0)
        concat(
          content_tag(:p, class: 'text-muted') do
            concat(currency area.today_contracts_rate_month)
            concat " ("
            concat(currency area.today_contracts_rate)
            concat ")"
          end
        )
      end
    end
  end

  def renter_date_end_in_future_contracts(renter)
    content_tag :div, class: 'text-sm m-b-1' do
      renter.contracts.date_end_in_future.each do |contract|
        concat(content_tag(:p, class: 'm-b-0') do 
          concat(link_to(contract_path(contract)) do
            "#{contract.to_label} (#{clever_date contract.date_start} - #{clever_date contract.date_end})"
          end)
        end)
        #concat "<br />".html_safe
      end
      if(renter.today_contracts_rate > 0)
        concat(content_tag(:p, class: 'text-muted') do
          concat(currency renter.today_contracts_rate_month)
          concat " ("
          concat(currency renter.today_contracts_rate)
          concat ")"
        end)
      end
    end
  end

  def ransack_search &block
    content_tag :div, class: 'row' do
      content_tag :div, class: 'col-md-7' do
        content_tag :div, class: 'card' do
          concat(content_tag(:div, class: 'card-header', data: {toggle: 'collapse', target: '#ransack-search'}, style: 'cursor: pointer') do
            concat(icon('filter m-r-1'))
            concat("Поиск")
            concat(content_tag(:a, class: 'pull-right') do
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

  def clever_date(date)
    if date.year == Date.current.year
      l date, format: :without_year
    else
      l date, format: :with_year
    end
  end

  def clever_datetime(datetime)
    if datetime.year == Date.current.year
      l datetime, format: :short
    else
      l datetime, format: :long
    end
  end

  def success_or_danger(renter)
    css_class = case
    when renter.account - renter.forecast < 0# || (renter.contracts.date_end_in_future.any? && renter.forecast - renter.account  > 0 )
      'danger'
    when renter.account > 0
      'success'
    end
  end

end
