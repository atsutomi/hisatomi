class CreateDishImages < ActiveRecord::Migration
  def change
    create_table :dish_images do |t|
      t.references :dish, null: false #外部キー
      t.binary :data #画像データ
      t.string :content_type #MIMEタイプ
      t.timestamps
    end
    add_index :dish_images, :dish_id
  end
end
