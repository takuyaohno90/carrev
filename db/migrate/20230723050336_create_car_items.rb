class CreateCarItems < ActiveRecord::Migration[6.1]
  def change
    create_table :car_items do |t|
      t.integer :maker_id, null: false
      t.string :name, null: false
      t.integer :num_people, null: false
      t.string :displacement, null: false
      t.string :drive_system, null: false
      t.string :door, null: false
      t.string :mission, null: false
      t.string :model_year, null: false
      t.integer :fuel, null: false
      t.integer :body, null: false
      t.string :fuel_consumption, null: false
      t.string :weight, null: false
      t.string :size, null: false

      t.timestamps
    end
  end
end
