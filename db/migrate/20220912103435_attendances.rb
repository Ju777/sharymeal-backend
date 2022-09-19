class Attendances < ActiveRecord::Migration[7.0]
    def change
      create_table :attendances do |t|
        t.belongs_to :user, index: true
        t.belongs_to :meal, index: true
        t.timestamps
      end
    end
end
