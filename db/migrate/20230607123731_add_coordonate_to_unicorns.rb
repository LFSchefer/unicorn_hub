class AddCoordonateToUnicorns < ActiveRecord::Migration[7.0]
  def change
    add_column :unicorns, :latitude, :float
    add_column :unicorns, :longitude, :float
  end
end
