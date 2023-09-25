class AddReviewIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :review_id, :integer, null: false
    add_column :comments, :user_id, :integer, null: false
    add_column :comments, :comment, :text, null: false

  end
end
