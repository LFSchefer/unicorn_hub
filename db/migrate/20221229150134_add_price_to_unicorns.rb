class AddPriceToUnicorns < ActiveRecord::Migration[7.0]
  def change
    add_column :unicorns, :price, :integer
  end
end
