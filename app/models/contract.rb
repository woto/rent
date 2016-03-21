class Contract < ApplicationRecord
  belongs_to :renter
  belongs_to :area

  include ToLabel

  validate :date_end, :check_date_end_lt_date_start
  validate :area, :validate_area_rented_once_at_time
  validates :title, :renter, :area, :rate, presence: true
  validates :rate, numericality: {greater_than: 0}

  scope :actual, -> {where("date_start <= '#{Date.today}' AND date_end >= '#{Date.today}'")}

  private

  def check_date_end_lt_date_start
    errors.add(:date_end, 'Дата окончания аренды должна быть равна или больше даты начала') unless date_end >= date_start
  end

  def validate_area_rented_once_at_time
    contracts = area.contracts
    if id.present?
      contracts = contracts.where.not(id: id)
    end
    if contracts.where("date_start <= '#{date_end}' AND date_end >= '#{date_start}' ").any?
      errors.add(:date_start, 'Сдаваемая торговая площадь уже сдаётся в указанный срок по другому договору.')
    end
  end
end
