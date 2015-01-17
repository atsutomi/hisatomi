class CreateLunchboxes < ActiveRecord::Migration
  def change
    create_table :lunchboxes do |t|
      t.string :size         #大きさ
      t.float :capacity      #量
      t.string :explanation  #説明
      t.timestamps
    end
  end
end
