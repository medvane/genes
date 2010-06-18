class GenesController < ApplicationController
  def index
    @genes = Gene.order("articles_count desc").includes(:taxonomy).limit(@per_page).offset(@offset)
    @genes = @genes.where(:taxonomy_id => params[:t]) if params[:t].present?
    @last_item = Taxonomy.where(:id => params[:t]).first.genes_count if params[:t].present?
  end

  def show
    @gene = Gene.find(params[:id])
  end
end
