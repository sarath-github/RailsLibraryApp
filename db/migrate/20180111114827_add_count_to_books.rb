class AddCountToBooks < ActiveRecord::Migration
  def up
  	add_column :books, :total_copies , :integer, :default => 1
  	add_column :books, :available_copies, :integer, :default => 1
  end

  def down
  	remove_column :books, :total_copies, :available_copies
  end
end
