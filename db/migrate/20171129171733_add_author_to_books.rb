class AddAuthorToBooks < ActiveRecord::Migration
  def change
    add_column :books, :author, :string, :defualt => 'unknown'
  end
end
