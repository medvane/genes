class Homologene < ActiveRecord::Base
  belongs_to :gene
  belongs_to :homolog, :class_name => "Gene", :foreign_key => "homolog_id"
end
