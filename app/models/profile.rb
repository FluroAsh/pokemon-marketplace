class Profile < ApplicationRecord
  belongs_to :user
  # additional validation for devise input fields
  validates :first_name, :state, presence: true
  validates :first_name, length: { minimum: 2 }
  before_save :capitalize_fields

  def capitalize_fields # reformat input to correct capitalization
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
    self.state = self.state.capitalize
    self.suburb = self.suburb.capitalize
  end
end
