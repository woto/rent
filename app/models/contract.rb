class Contract < ApplicationRecord
  belongs_to :renter
  belongs_to :area

  include ToLabel

  validate :date_end, :check_date_end_lt_date_start
  #validate :area, :validate_area_rented_once_at_time

  validates :renter, presence: true
  validates :area, presence: true

  private

  def check_date_end_lt_date_start
    errors.add(:date_end, 'Дата окончания аренды должна быть больше даты начала') unless date_end > date_start
  end

  #def validate_area_rented_once_at_time
  #  errors.add(:base, 'Сдаваемая торговая площадь уже сдаётся в указанный срок по другому договору')
  #end
end
