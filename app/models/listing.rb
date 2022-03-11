class Listing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  # enum to map our numbers to something more readable
  enum condition: { Poor: 1, Good: 2, Fair: 3, Excellent: 4, Mint: 5 }
end
