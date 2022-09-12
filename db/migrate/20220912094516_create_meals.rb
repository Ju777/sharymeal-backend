class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :guest_capacity
      t.integer :guest_registered
      t.date :starting_date
      t.json :location
      t.boolean :animals
      t.boolean :alcool
      t.boolean :doggybag
      t.string :theme
      t.string :allergens, array: true, default: []
      t.string :diet_type, array: true, default: []

      t.references :host, foreign_key: { to_table: :users }
      # t.references :guest, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
