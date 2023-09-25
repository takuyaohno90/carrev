class AddCarItemIdToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :car_item_id, :integer, null: false
    remove_column :reviews, :car_id
  end
end
