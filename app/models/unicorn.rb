class Unicorn < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_many :unicorn_tags, dependent: :destroy
  has_many :tags, through: :unicorn_tags
  validates :name, presence: true
  validates :price, presence: true
  validates :image_url, presence: true
  validates :description, presence: true, length: { in: 10..200 }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def average_reviews
    number_of_reviews = self.reviews.size
    reviews_score = []
    self.reviews.each do |review|
      reviews_score << review.rating
    end
    reviews_score.sum.fdiv(number_of_reviews)
  end

end
