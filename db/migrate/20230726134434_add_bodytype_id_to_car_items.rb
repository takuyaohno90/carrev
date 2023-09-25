class AddBodytypeIdToCarItems < ActiveRecord::Migration[6.1]
  def change
    add_column :car_items, :bodytype_id, :integer, null: false
  end
end
