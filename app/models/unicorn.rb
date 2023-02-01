class Unicorn < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  validates :name, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
end
