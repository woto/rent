class Contract < ApplicationRecord

  attr_accessor :rate_month

  belongs_to :renter
  belongs_to :area
  has_many :transactions

  include ToLabel

  validate :date_end, :check_date_end_lt_date_start
  validate :area, :validate_area_rented_once_at_time, if: -> {area}
  validates :title, :renter, :area, :rate, presence: true
  validates :rate, numericality: {greater_than: 0}

  scope :today_in_range, -> {where("date_start <= '#{Date.current}' AND date_end >= '#{Date.current}'")}
  scope :date_end_in_future, -> {where("date_end >= '#{Date.current}'")}

  before_validation :set_rate_from_rate_month, if: -> {rate_month.present?}

  after_find :set_rate_month_from_rate, if: -> {rate.present?}

  def today_in_range?
    date_start <= Date.current && date_end >= Date.current
  end

  # TODO более не используется?
  #def date_end_in_future?
  #  date_end >= Date.current
  #end

  def rate_month=(args="")
    @rate_month = args.to_i
  end


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

  def set_rate_from_rate_month
    self.rate = rate_month / 31.0
  end

  def set_rate_month_from_rate
    self.rate_month = rate * 31.0
  end

end
