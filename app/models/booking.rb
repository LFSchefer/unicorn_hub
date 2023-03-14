class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :unicorn
  validates :start_date, presence: true
  validates :end_date, presence: true

  def number_of_days
    (self.end_date - self.start_date).to_i
  end

  def total_price
    self.number_of_days * self.unicorn.price
  end
  
end
