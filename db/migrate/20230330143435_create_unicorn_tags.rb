class CreateUnicornTags < ActiveRecord::Migration[7.0]
  def change
    create_table :unicorn_tags do |t|
      t.references :unicorn, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
