class ReviewedGo < ActiveRecord::Base
  belongs_to :review
  belongs_to :go
  
  scope :components, where("gos.category = 'Component'").joins(:go)
  scope :functions, where("gos.category = 'Function'").joins(:go)
  scope :processes, where("gos.category = 'Process'").joins(:go)
end
