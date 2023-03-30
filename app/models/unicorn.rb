class Unicorn < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_many :unicorn_tags, dependent: :destroy
  has_many :tags, through: :unicorn_tags
  validates :name, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
end
