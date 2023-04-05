class UnicornTag < ApplicationRecord
  belongs_to :unicorn
  belongs_to :tag

  validates :tag, uniqueness: {scope: :unicorn, message: "already added"}
end
