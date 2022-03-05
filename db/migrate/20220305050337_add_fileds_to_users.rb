class AddFiledsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :contact, :string
    add_column :users, :address, :string
    add_column :users, :role, :integer
  end
end
