class AddUnicornReferencesToTag < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :unicorn, foreign_key: true
  end
end
