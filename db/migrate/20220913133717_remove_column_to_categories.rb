class RemoveColumnToCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :svg_icon, :text
  end
end
