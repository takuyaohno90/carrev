class ChangeTaggingsIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :taggings, name: "index_taggings_on_tag_id_and_post_id"
    add_index :taggings, ["tag_id", "review_id"], name: "index_taggings_on_tag_id_and_review_id", unique: true
  end
end
