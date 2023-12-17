class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :unicorns, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews


  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

end
