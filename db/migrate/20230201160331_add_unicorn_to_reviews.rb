class AddUnicornToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :unicorn, null: false, foreign_key: true
  end
end
