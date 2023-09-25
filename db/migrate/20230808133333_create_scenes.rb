class CreateScenes < ActiveRecord::Migration[6.1]
  def change
    create_table :scenes do |t|

      t.timestamps
      t.string :name, null: false
    end
  end
end
