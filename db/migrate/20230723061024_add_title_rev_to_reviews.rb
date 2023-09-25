class AddTitleRevToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :title_rev, :string
  end
end
