class AddFuelIdToCarItems < ActiveRecord::Migration[6.1]
  def change
    add_column :car_items, :fuel_id, :integer, null: false
  end
end
