class RemoveSceneAFromReview < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :scene_a
    remove_column :reviews, :scene_b
  end
end
