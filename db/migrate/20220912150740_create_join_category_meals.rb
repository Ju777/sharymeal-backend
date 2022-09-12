class CreateJoinCategoryMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :join_category_meals do |t|
      t.belongs_to :category, index: true
      t.belongs_to :meal, index: true
      t.timestamps
    end
  end
end
