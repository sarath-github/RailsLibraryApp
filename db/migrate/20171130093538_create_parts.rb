class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :title
      t.integer :part_number
      t.references :book

      t.timestamps
    end
    add_index :parts, :book_id
  end
end
