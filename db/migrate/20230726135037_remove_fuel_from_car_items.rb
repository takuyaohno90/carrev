class RemoveFuelFromCarItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :car_items, :fuel, :integer
  end
end
