class Taxonomy < ActiveRecord::Base
  has_many :genes
end
