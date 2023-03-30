class Tag < ApplicationRecord
  has_many :unicorns, through: :unicorn_tags
end
