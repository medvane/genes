class ApplicationController < ActionController::Base
  before_filter :set_params
  protect_from_forgery
  layout 'application'

  def set_params
    @per_page = 15
    @offset = (params[:o] || 0).to_i
    @taxonomy_id = params[:t].to_i if params[:t].present?
  end
end
