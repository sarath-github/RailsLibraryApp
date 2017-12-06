class Part < ActiveRecord::Base
  belongs_to :book
  attr_accessible :part_number, :title
end
