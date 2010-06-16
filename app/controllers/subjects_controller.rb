class SubjectsController < ApplicationController
  def index
    @subjects = Subject.limit(10)
  end

  def show
    @subject = Subject.find(params[:id])
  end
end
