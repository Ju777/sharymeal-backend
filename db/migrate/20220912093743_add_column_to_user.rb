class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :description, :text
    add_column :users, :city, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :string
  end
end
