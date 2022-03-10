class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favourites
  has_many :orders
  has_many :listings
  has_many :sold_orders, foreign_key: "seller_id", class_name: "Order"
  has_many :bought_orders, foreign_key: "seller_id", class_name: "Order"
  has_one_attached :avatar, dependent: :destroy

  has_one :profile
  accepts_nested_attributes_for :profile

  def with_profile
    build_profile if profile.nil?
    self
  end

  def def(avatar_thumbnail)
    if avatar.attached?
      avatar.variant(resize: "150x150!").processed  # resizes to 150x150 & ignores aspect ratio
    else
      "default-profile.jpg"
    end
  end
end
