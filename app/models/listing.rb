class Listing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  # validations for listing form
  validates :description, :price, :condition, presence: true
  validates :description, length: { in: 1..255 }
  # hook(s)
  before_validation :convert_price_to_cents, if: :price_changed? # (float > int) dollar input > cents

  # enum to map our numbers to something more readable
  enum conditions: { Poor: 1, Good: 2, Fair: 3, Excellent: 4, Mint: 5 }

  def convert_price_to_cents
    # Before we turn it into an integer grab the raw data from the hash (key = price)
    # and make it cent format for stripe transactions
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end
end
