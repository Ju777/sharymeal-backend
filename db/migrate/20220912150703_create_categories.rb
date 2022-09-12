class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :label
      t.string :svg_icon

      t.timestamps
    end
  end
end
