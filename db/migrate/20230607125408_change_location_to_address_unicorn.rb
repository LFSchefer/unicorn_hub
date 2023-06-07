class ChangeLocationToAddressUnicorn < ActiveRecord::Migration[7.0]
  def change
    rename_column :unicorns, :location, :address
  end
end
