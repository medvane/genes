class ReviewsController < ApplicationController
  def index
    @reviews = Review.where(:built => true)
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
    @reviewed_genes = @review.reviewed_genes.limit(@per_page).offset(@offset).includes(:gene => :taxonomy)
    @last_item = @review.genes_count
    @review.hit! if @review.built?
  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(params[:review])
    
    respond_to do |format|
      if @review.save
        Delayed::Job.enqueue(CreateReview.new(@review.id))
        format.html { redirect_to(@review, :notice => 'Review was successfully created.') }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(@review, :notice => 'Review was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
end
