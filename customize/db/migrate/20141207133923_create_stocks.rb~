class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :dish, null: false
      t.datetime :date
      t.float :stock
      t.timestamps
    end
    add_index :stocks, :dish_id
  end
end
