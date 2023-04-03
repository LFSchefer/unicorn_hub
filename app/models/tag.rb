class Tag < ApplicationRecord
  has_many :unicorn_tags, dependent: :destroy
  has_many :unicorns, through: :unicorn_tags
end
