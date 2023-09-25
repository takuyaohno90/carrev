class CreateBodytypes < ActiveRecord::Migration[6.1]
  def change
    create_table :bodytypes do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
