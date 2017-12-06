require 'barby'

class Book < ActiveRecord::Base
  before_save :generate_qr
  attr_accessible :description, :name, :price, :author, :publisher_id, :barcode

  validates :name , :presence => true
  validates :description , :presence => true
  validates_numericality_of :price, :on => :create
  validates :author, :presence => true

  has_many :parts
  belongs_to :publisher

  def self.search(search)
  	if search
  		find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  	else
  		find(:all)
  	end
  end

  def self.sort(sort, direction)
  	if sort
  		order(sort + " " + direction)
  	else 
  		find(:all)
  	end
  end

  def generate_qr
    require 'barby'
    require 'barby/barcode'
    require 'barby/barcode/qr_code'
    require 'barby/outputter/png_outputter'

    text = self.id.to_s + self.name + self.description + self.author + self.price.to_s
    barcode = Barby::QrCode.new(text, level: :q, size: 5)
    base64_output = Base64.encode64(barcode.to_png({ xdim: 5 }))
    self.barcode = base64_output
  end
end
