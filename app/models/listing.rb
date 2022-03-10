class Listing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  enum condition: { mint: 1, good: 2, average: 3, poor: 4, very_poor: 5 }
end
