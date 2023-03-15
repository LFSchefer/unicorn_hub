class Tag < ApplicationRecord
  has_many :unicorns, dependent: :destroy
end
