class Renter < ApplicationRecord
  include ToLabel

  validates :title, presence: true
end
