class AddTagToUnicorn < ActiveRecord::Migration[7.0]
  def change
    add_reference :unicorns, :tag, foreign_key: true
  end
end
