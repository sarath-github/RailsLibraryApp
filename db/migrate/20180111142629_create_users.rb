class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name , unique: true
      t.text :password

      t.timestamps
    end
  end
end
