class ChangeBarcodeToBooks < ActiveRecord::Migration
  def up
  	change_column :books, :barcode, :string, unique: true
  end

  def down
  	change_column :books, :barcode, :string, unique: true
  end
end
