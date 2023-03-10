class Unicorn < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_many :tags, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
end
