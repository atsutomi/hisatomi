class CreateFoodstuffs < ActiveRecord::Migration
  def change
    create_table :foodstuffs do |t|
      t.string :name
      t.timestamps
    end
  end
end
