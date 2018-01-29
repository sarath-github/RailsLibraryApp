require 'barby'
require 'barby/barcode'
require 'barby/barcode/qr_code'
require 'barby/outputter/png_outputter'
require 'elasticsearch/model'


class Book < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  before_save :generate_qr
  attr_accessible :description, :name, :price, :author, :publisher_id, :barcode, :total_copies, :available_copies

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'english', index_options: 'offsets'
      indexes :description, analyzer: 'english'
      indexes :author, analyzer: 'english'
    end
  end
  validates :name , :presence => true
  validates :description , :presence => true
  validates_numericality_of :price, :on => :create
  validates :author, :presence => true
  validates :total_copies, :presence => true, numericality: { only_integer: true }

  has_many :parts
  belongs_to :publisher

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['author','name^10','description']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            name: {},
            description: {},
            author: {}
          }
        }
      }
    )
  end

  def self.sort(sort, direction)
  	if sort
  		order(sort + " " + direction)
  	else 
  		find(:all)
  	end
  end

  def generate_qr

    text = self.id.to_s + self.name + self.description + self.author + self.price.to_s
    barcode = Barby::QrCode.new(text, level: :q, size: 5)
    base64_output = Base64.encode64(barcode.to_png({ xdim: 5 }))
    self.barcode = base64_output
  end
end

# # Delete the previous articles index in Elasticsearch
# Book.__elasticsearch__.client.indices.delete index: Book.index_name rescue nil

# # Create the new index with the new mapping
# Book.__elasticsearch__.client.indices.create \
#   index: Book.index_name,
#   body: { settings: Book.settings.to_hash, mappings: Book.mappings.to_hash }

# Book.import
