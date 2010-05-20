class GenesController < ApplicationController
  def index
    @genes = Gene.order("articles_count desc").includes(:taxonomy).limit(@per_page).offset(@offset)
  end

  def show
    @gene = Gene.find(params[:id])
  end
end
