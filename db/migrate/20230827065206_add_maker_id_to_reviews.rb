class AddMakerIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :maker_id, :integer
  end
end
