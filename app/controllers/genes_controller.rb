class GenesController < ApplicationController
  def index
    @genes = Gene.all
  end

  def show
    @gene = Gene.find(params[:id])
  end
end
