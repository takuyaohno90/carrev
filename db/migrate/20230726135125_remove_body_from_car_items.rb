class RemoveBodyFromCarItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :car_items, :body, :integer
  end
end
