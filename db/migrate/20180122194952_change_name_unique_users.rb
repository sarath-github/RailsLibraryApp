class ChangeNameUniqueUsers < ActiveRecord::Migration
  def up
  	change_column :users, :name, :string, unique: true
  end

  def down
  end
end
