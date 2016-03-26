class Renter < ApplicationRecord
  include ToLabel

  has_many :contracts, dependent: :restrict_with_error
  has_many :transactions
  validates :title, presence: true
  before_destroy :check_account_noteq_zero

  def today_contracts_rate
    contracts.today_in_range.sum("rate")
  end

  def forecast
    contracts.date_end_in_future.sum do |contract|
      start_date = contract.date_start > Date.today ? contract.date_start : Date.today
      end_date = contract.date_end + 1.day
      diff_date = end_date - start_date
      contract.rate * (diff_date >= 31 ? 31 : diff_date)
    end
  end

  def check_account_noteq_zero
    if account != 0
      throw(:abort)
    end
  end

end
