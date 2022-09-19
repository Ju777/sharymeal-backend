class Attendances < ActiveRecord::Migration[7.0]
    def change
      create_table :attendances do |t|
        t.references :user, foreign_key: true
        t.references :meal, foreign_key: true
        t.timestamps
      end
    end
end
