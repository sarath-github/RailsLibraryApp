class AddIsAdminToUser < ActiveRecord::Migration
  def change
  	add_column :users, :isadmin , :bool, :default => false
  end
end
