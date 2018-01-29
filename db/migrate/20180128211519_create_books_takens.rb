class CreateBooksTakens < ActiveRecord::Migration
  def change
    create_table :books_takens do |t|
      t.integer :user_id
      t.integer :book_id
      t.datetime :check_out_time
      t.datetime :check_in_time
      t.timestamps
    end
  end
end
