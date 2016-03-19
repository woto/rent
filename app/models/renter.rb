class Renter < ApplicationRecord
  belongs_to :area
  include ToLabel
end
