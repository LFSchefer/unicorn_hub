class RemoveAccountNameFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :account_name, :string
  end
end
