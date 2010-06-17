class GeneSubject < ActiveRecord::Base
  belongs_to :gene
  belongs_to :subject
end
