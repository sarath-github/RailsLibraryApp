require 'elasticsearch/model'


class Publisher < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # attr_accessible :title, :body
  attr_accessible :name
  has_many :books, dependent: :destroy
end
# Delete the previous Publishers index in Elasticsearch
Publisher.__elasticsearch__.client.indices.delete index: Publisher.index_name rescue nil

# Create the new index with the new mapping
Publisher.__elasticsearch__.client.indices.create \
  index: Publisher.index_name,
  body: { settings: Publisher.settings.to_hash, mappings: Publisher.mappings.to_hash }

# Index all Publisher records from the DB to Elasticsearch
Publisher.import