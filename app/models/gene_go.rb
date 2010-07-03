class GeneGo < ActiveRecord::Base
  belongs_to :gene
  belongs_to :go
end
