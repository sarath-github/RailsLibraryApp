class BooksTaken < ActiveRecord::Base
  attr_accessible :user_id, :book_id, :check_in_time, :check_out_time
end
