class AddColumnDishes < ActiveRecord::Migration
  def up
    add_column :dishes, :visible, :boolean, default: true
  end

  def down
  end
end
