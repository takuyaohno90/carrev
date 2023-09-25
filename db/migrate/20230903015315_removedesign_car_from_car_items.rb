class RemovedesignCarFromCarItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :car_items, :design_car, :integer, default: 3, null: false
    remove_column :car_items, :performance_car, :integer, default: 3, null: false
    remove_column :car_items, :fuel_consumptionrev_car, :integer, default: 3, null: false
    remove_column :car_items, :quietness_car, :integer, default: 3, null: false
    remove_column :car_items, :vibration_car, :integer, default: 3, null: false
    remove_column :car_items, :indoor_space_car, :integer, default: 3, null: false
    remove_column :car_items, :luggage_space_car, :integer, default: 3, null: false
    remove_column :car_items, :price_car, :integer, default: 3, null: false
    remove_column :car_items, :maintenance_cost_car, :integer, default: 3, null: false
    remove_column :car_items, :safety_car, :integer, default: 3, null: false
    remove_column :car_items, :assistance_car, :integer, default: 3, null: false
    remove_column :car_items, :evaluation_car, :float, default: 3.0, null: false
    remove_column :car_items, :review_count, :integer, default: 0, null: false
  end
end
