class Renter < ApplicationRecord
  include ToLabel

  has_many :contracts, dependent: :restrict_with_error

  validates :title, presence: true
end
