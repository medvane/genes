class ReviewedGo < ActiveRecord::Base
  belongs_to :review
  belongs_to :go
end
