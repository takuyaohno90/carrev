class CreateReviewSceneRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :review_scene_relations do |t|
      t.references :review, null: false, foreign_key: true
      t.references :scene, null: false, foreign_key: true

      t.timestamps
    end
  end
end
