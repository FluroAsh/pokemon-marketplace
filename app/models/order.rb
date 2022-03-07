class Order < ApplicationRecord
  belongs_to :listing
  belongs_to :buyer, foreign_key: "buyer_id", class_name: "User" # Both are shorthand for :buyer/:seller, but no buyer table exists...
  belongs_to :seller, foreign_key: "seller_id", class_name: "User"
end