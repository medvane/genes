class GenesController < ApplicationController
  def index
    @genes = Gene.includes(:taxonomy).limit(30)
  end

  def show
    @gene = Gene.find(params[:id])
  end
end
