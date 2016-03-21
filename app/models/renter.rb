class Renter < ApplicationRecord
  include ToLabel

  has_many :contracts, dependent: :restrict_with_error
  validates :title, presence: true
  before_destroy :check_account_noteq_zero

  def forecast
    account - actual_contracts.sum do |contract|
      diff_date = contract.date_end + 1.day - Date.today
      contract.rate * (diff_date >= 30 ? 30 : diff_date)
    end
  end

  def actual_contracts
    contracts.actual
  end

  def check_account_noteq_zero
    if account != 0
      throw(:abort)
    end
  end

end
