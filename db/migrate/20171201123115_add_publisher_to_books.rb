class AddPublisherToBooks < ActiveRecord::Migration
  def self.up
  	change_table :books do |t|
  		t.references :publisher
  	end
  end
  def self.down
  end
end
