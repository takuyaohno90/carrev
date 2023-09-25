class AdddesignCarToCarItems < ActiveRecord::Migration[6.1]
  def change
    add_column :car_items, :design_car, :float, default: 3, null: false
    add_column :car_items, :performance_car, :float, default: 3, null: false
    add_column :car_items, :fuel_consumptionrev_car, :float, default: 3, null: false
    add_column :car_items, :quietness_car, :float, default: 3, null: false
    add_column :car_items, :vibration_car, :float, default: 3, null: false
    add_column :car_items, :indoor_space_car, :float, default: 3, null: false
    add_column :car_items, :luggage_space_car, :float, default: 3, null: false
    add_column :car_items, :price_car, :float, default: 3, null: false
    add_column :car_items, :maintenance_cost_car, :float, default: 3, null: false
    add_column :car_items, :safety_car, :float, default: 3, null: false
    add_column :car_items, :assistance_car, :float, default: 3, null: false
    add_column :car_items, :evaluation_car, :float, default: 3.0, null: false
    add_column :car_items, :review_count, :integer, default: 0, null: false

  end
end
