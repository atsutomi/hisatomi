class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.references :dish, null: false      #外部キー
      t.references :foodstuff, null: false #外部キー
      t.timestamps
    end
  add_index :recipes, :dish_id
  add_index :recipes, :foodstuff_id
  end
end
