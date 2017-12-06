class ChangeBarcodeToText < ActiveRecord::Migration
  def up
  	change_column :books, :barcode, :text
  end

  def down
  	change_column :books, :barcode, :string
  end
end
