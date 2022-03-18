class Listing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  validates :description, :price, :condition, presence: true
  before_validation :convert_price_to_cents, if: :price_changed? # (float > int) dollar input > cents

  # enum to map our numbers to something more readable
  enum conditions: { Poor: 1, Good: 2, Fair: 3, Excellent: 4, Mint: 5 }

  def convert_price_to_cents
    # Before we turn it into an integer grab the raw data from the hash (key = price)
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end
end