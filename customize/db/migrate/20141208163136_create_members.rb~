class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :login_id
      t.string :password
      t.string :name
      t.string :tel
      t.string :email
      t.boolean :admin, default: false
      t.timestamps
    end
    add_column :members, :hashed_password, :string
  end
end
