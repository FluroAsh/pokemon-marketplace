class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :listings, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :sold_orders, foreign_key: "seller_id", class_name: "Order", dependent: :destroy
  has_many :bought_orders, foreign_key: "seller_id", class_name: "Order", dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  def profile # force devise to build our nested 'profile' form
    super || build_profile
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150!").processed  # resizes to 150x150 & ignores aspect ratio (imagemagick for active-storage)
    else
      "default-profile.jpg"
    end
  end
end
