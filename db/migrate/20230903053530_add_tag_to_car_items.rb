class AddTagToCarItems < ActiveRecord::Migration[6.1]
  def change
    add_column :car_items, :commuting_tag_count, :integer, default: 0, null: false
    add_column :car_items, :pick_up_tag_count, :integer, default: 0, null: false
    add_column :car_items, :shopping_tag_count, :integer, default: 0, null: false
    add_column :car_items, :sports_tag_count, :integer, default: 0, null: false
    add_column :car_items, :outdoor_tag_count, :integer, default: 0, null: false
    add_column :car_items, :offroad_tag_count, :integer, default: 0, null: false
    add_column :car_items, :long_distance_tag_count, :integer, default: 0, null: false
    add_column :car_items, :enjoy_tag_count, :integer, default: 0, null: false
  end
end
