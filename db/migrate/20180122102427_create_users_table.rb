class CreateUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name , unique: true
      t.text :password

      t.timestamps
    end
  end
  def down
  end
end
