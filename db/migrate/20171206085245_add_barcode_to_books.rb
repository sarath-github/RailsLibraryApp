class AddBarcodeToBooks < ActiveRecord::Migration
  def change
    add_column :books, :barcode, :string
  end
end
