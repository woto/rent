class Transaction < ApplicationRecord

  belongs_to :contract
  belongs_to :renter, required: true
  belongs_to :area

  validates :amount, presence: true
  validates :amount, numericality: true

  before_create :fill_attributes
  after_create :change_renter_account
  before_validation :set_attributes_if_contract_present

  private

  def set_attributes_if_contract_present
    if contract
      self.contract_string = contract.to_label
      self.area = contract.area
      self.area_string = contract.area.to_label
      self.amount = contract.rate
      self.renter = contract.renter
    end
  end

  def fill_attributes
    self.account_were = renter.account
    self.account = renter.account + amount
    self.renter_string = renter.to_label
  end

  def change_renter_account
    renter.increment!(:account, amount)
  end

end
