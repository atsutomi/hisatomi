class CreateCustoms < ActiveRecord::Migration
  def change
    create_table :customs do |t|
      t.references :order, null: false #外部キー
      t.references :dish, null: false #外部キー
      t.timestamps
    end
    
    add_index :customs, :order_id
    add_index :customs, :dish_id
  end
end
