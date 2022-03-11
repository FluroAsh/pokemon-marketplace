class Profile < ApplicationRecord
  belongs_to :user
  # additional validation for devise input fields
  validates :first_name, :state, presence: true 
end
