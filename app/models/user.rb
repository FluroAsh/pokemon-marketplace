class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders # orders archived, no dependency
  has_one :profile, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :sold_orders, foreign_key: "seller_id", class_name: "Order", dependent: :destroy
  has_many :bought_orders, foreign_key: "seller_id", class_name: "Order", dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  validates :email, presence: true
  before_save :avatar_thumbnail # callack to resize an uploaded avatar ONLY when saved to S3
  accepts_nested_attributes_for :profile

  def profile # force devise to build our nested 'profile' form
    super || build_profile
  end

  # compresses image to 150x150 before it's saved; otherwise resize image without saving
  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_fit: [150, 150]) # resizes to 150x150 & ignores aspect ratio (minimagick gem)
    else
      "default-profile.jpg"
    end
  end
end
