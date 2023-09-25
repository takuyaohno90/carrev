class AddTitleToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :car_id, :integer, null: false
    add_column :reviews, :user_id, :integer, null: false
    add_column :reviews, :scene_a, :integer, null: false
    add_column :reviews, :scene_b, :integer, null: false
    add_column :reviews, :title, :string, null: false
    add_column :reviews, :favorite, :text, null: false
    add_column :reviews, :complain, :text, null: false
    add_column :reviews, :design, :integer, null: false, default: 3
    add_column :reviews, :performance, :integer, null: false, default: 3
    add_column :reviews, :fuel_consumptionrev, :integer, null: false, default: 3
    add_column :reviews, :quietness, :integer, null: false, default: 3
    add_column :reviews, :vibration, :integer, null: false, default: 3
    add_column :reviews, :indoor_space, :integer, null: false, default: 3
    add_column :reviews, :luggage_space, :integer, null: false, default: 3
    add_column :reviews, :price, :integer, null: false, default: 3
    add_column :reviews, :maintenance_cost, :integer, null: false, default: 3
    add_column :reviews, :safety, :integer, null: false, default: 3
    add_column :reviews, :assistance, :integer, null: false, default: 3
    add_column :reviews, :evaluation, :float, null: false, default: 3
  end
end
